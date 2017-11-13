# For compatibility with 2.2.21
swirl_options(swirl_logging = TRUE)


.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) {file.path(find.package("swirl"),"Courses")}
  )
}

# Path to installed lesson
lessonpath <- file.path(.get_course_path(), "fes720_Statistics",
                        "Testing_Populations")


race <- read.table(file = paste(lessonpath, '/race-data-full.txt', sep= ''), header = TRUE, sep = '\t')

rats <- data.frame(before = c(20, 15, 10, 5, 20, 15, 10, 5, 20, 15, 10, 5, 20, 15, 10, 5),
                   after = c(23, 16, 10, 4, 22, 15, 12, 7, 21, 16, 11, 5, 22, 14, 10, 6))
