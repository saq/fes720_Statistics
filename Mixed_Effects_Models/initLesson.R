# For compatibility with 2.2.21
swirl_options(swirl_logging = TRUE)

require(lme4)
require(lmerTest)

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) {file.path(find.package("swirl"),"Courses")}
  )
}

# Path to installed lesson
lessonpath <- file.path(.get_course_path(), "fes720_Statistics",
                        "Mixed_Effects_Models")


# load data
seedling <- read.table(file = paste(lessonpath, '/seedling.txt', sep= ''), header = TRUE, sep = '\t')

fruit <- read.table(file = paste(lessonpath, '/fruit.txt', sep= ''), header = TRUE, sep = '\t')

