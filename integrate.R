library(io)
library(dplyr)

submissions <- qread("submissions.csv");

staff <- c("djhshih", "HalQAQ");

prediction.total <- 20;
#prediction.total <- 20 + 40;

submissions <- mutate(submissions,
	prediction = points_awarded / prediction.total,
	email = ifelse(github_username %in% staff, "", sprintf("%s@connect.hku.hk", roster_identifier))
);

novelty <- qread("novelty.csv");

repos <- qread("repos.vtr");
commit.scores <- qread("commits.vtr");

commit <- data.frame(
	repo = repos,
	commit = commit.scores
);

out <- select(submissions,
		email, repo=student_repository_name, prediction
	) |>
	left_join(novelty, by="repo") |>
	left_join(commit, by="repo");

# calculate final grade	
out <- mutate(out,
	grade = 20*commit + 20*novelty + 60*prediction
);

qwrite(out, "grades.tsv")

