# For compatibility with 2.2.21
swirl_options(swirl_logging = TRUE)


.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) {file.path(find.package("swirl"),"Courses")}
  )
}

# Path to installed lesson
lessonpath <- file.path(.get_course_path(), "fes720_Statistics",
                        "Testing_Ratios")


tea_test <- matrix(c(3, 1, 1, 3),
                  nrow = 2,
                  dimnames = list(Guess = c("Milk", "Tea"),
                                  Truth = c("Milk", "Tea")))

apples_vs_pasta <- matrix(round(runif(n = 20, max = 30), 0), 
                         ncol = 5,
                         dimnames = list(Pasta = c('fusilli', 'spaghettini', 'rigatoni', 'orzo'),
                                         Apple = c('Baldwin', 'Golden Russet', 'Newtown Pippin', 'Winesap', 'Honeycrip'))
)


