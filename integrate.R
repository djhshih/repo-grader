library(io)
library(dplyr)

weights <- list(
	commit = 20,
	novelty = 20,
	prediction = 60
);

staff <- c("djhshih", "HalQAQ");

submissions <- qread("submissions.csv");

prediction <- qread("predict.csv");

novelty <- qread("novelty.csv");

repos <- qread("repos.vtr");
commit.scores <- qread("commits.vtr");
commit <- data.frame(
	repo = repos,
	commit = commit.scores
);

out <- select(submissions,
	id=roster_identifier, repo=student_repository_name
	) |>
	left_join(novelty, by="repo") |>
	left_join(commit, by="repo") |>
	left_join(prediction, by="repo");

# calculate final grade	
out <- mutate(out,
	grade = weights$commit*commit + weights$novelty*novelty + weights$prediction*prediction
);

qwrite(out, "grades.tsv")

