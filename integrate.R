library(io)
library(dplyr)

weights <- list(
	commit = 20,
	novelty = 20,
	prediction = 60
);

staff <- c("djhshih", "HalQAQ");

submissions <- qread("submissions.csv");

# before release of production dataset
prediction.total <- 20;

# after release of production dataset
#prediction.total <- 20 + 40;

submissions <- mutate(submissions,
	prediction = points_awarded / prediction.total
);

novelty <- qread("novelty.csv");

repos <- qread("repos.vtr");
commit.scores <- qread("commits.vtr");

commit <- data.frame(
	repo = repos,
	commit = commit.scores
);

out <- select(submissions,
	id=roster_identifier, repo=student_repository_name, prediction
	) |>
	left_join(novelty, by="repo") |>
	left_join(commit, by="repo");

# calculate final grade	
out <- mutate(out,
	grade = weights$commit*commit + weights$novelty*novelty + weights$prediction*prediction
);

qwrite(out, "grades.tsv")

