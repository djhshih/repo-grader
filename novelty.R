library(io)
library(dplyr)

submissions <- qread("submissions.csv");

files <- file.path("dolos", c("run-diploid", "run-somatic"), "pairs.csv");

preprocess_data <- function(d, prefix) {
	d$leftRepo  <- sub("/.*", "", sub(prefix, "", d$leftFilePath));
	d$rightRepo <- sub("/.*", "", sub(prefix, "", d$rightFilePath));
	d$total <- round(d$totalOverlap / d$similarity);
	d
}

ds <- lapply(files, qread);
d <- do.call(rbind, lapply(ds, preprocess_data, prefix="repos/"));

similarity0 <- 0.5;

# merge results across all scripts
d <- group_by(d, leftRepo, rightRepo) |>
	summarize(
		totalOverlap = sum(totalOverlap),
		total = sum(total)
	) |>
	mutate(
		similarity = totalOverlap / total,
	);

left <- group_by(d, leftRepo) |>
	rename(repo = leftRepo) |>
	summarize(similarity = max(similarity));

right <- group_by(d, rightRepo) |>
	rename(repo = rightRepo) |>
	summarize(similarity = max(similarity));

combined <- full_join(left, right) |>
	group_by(repo) |>
	summarize(similarity = max(similarity));

# calculate novelty score based on max similiaity
out <- combined |>
	mutate(
		novelty = 1 - pmax(0, similarity - similarity0) / (1 - similarity0)
	) |>
	left_join(
		select(submissions, student_repository_name),
		by = c("repo" = "student_repository_name")
	);

qwrite(out, "novelty.csv")

