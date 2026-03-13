library(io)

repos <- qread("repos.vtr");
paths <- file.path("repos", repos);

get_grades <- function(paths, json) {
	do.call(rbind, lapply(paths,
		function(repo) {
			out <- try(
				{
					r <- qread(file.path(repo, json));
					unlist(r$grade)
				},
				silent = TRUE
			);
			if (inherits(out, "try-error")) {
				NA
			} else {
				out
			}
		}
	))
}

grades.dev <- get_grades(paths, "evaluate.json");

grades.prod <- get_grades(paths, file.path("prod", "evaluate.json"));
grades.prod <- grades.prod * 2;

grades <- grades.dev + grades.prod;

out <- data.frame(repo=repos, grades);
out$prediction <- with(out, pass / total);
out$prediction[is.na(out$prediction)] <- 0;

qwrite(out, "predict.csv");

