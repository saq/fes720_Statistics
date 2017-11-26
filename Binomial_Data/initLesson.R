# For compatibility with 2.2.21
swirl_options(swirl_logging = TRUE)


.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) {file.path(find.package("swirl"),"Courses")}
  )
}

# Path to installed lesson
lessonpath <- file.path(.get_course_path(), "fes720_Statistics",
                        "Binomial_Data")


isolation <- read.table(file = paste(lessonpath, '/isolation.txt', sep= ''), header = TRUE, sep = '\t')

sexratio <- read.table(file = paste(lessonpath, '/sexratio.txt', sep= ''), header = TRUE, sep = '\t')
