- Class: text
  Output: "# Linear Mixed Effects Model: Example using fruit production data with repeated measures"

- Class: text
  Output: "We just worked through an example with a binary response
    variable. The workings of this model are actually much simpler 
    and easier to compute than a regular linear model. You will notice
    that the model output was essentially the same as the output from
    non-mixed effects models."

- Class: text
  Output: "The situation for linear mixed effects models is not so 
    straightforward, as the function `lmer()` does not return 
    p-values (if you are interested in those ...)."

- Class: text
  Output: "`lmer()` does not return p-values because of 
    uncertainties in calculating the appropriate degrees
    of freedom. Statistics is a developing science, like 
    any other, and mixed effect models are right at the frontier."

- Class: text
  Output: "For more details and the latest recommendations,
    see this website: [http://glmm.wikidot.com/](http://glmm.wikidot.com/)

- Class: text
  Output: "Ok, let's consider a problem where we want to understand how
    tree size affects the number of fruit that tree produces."

- Class: text
  Output: "Easy? It would be, but we have three years of data for each
    individual tree ... any analysis that does not account for
    this *repeated measures* set-up will not be entirely correct."

- Class: text
  Output: "As before, let's look at the data and some 
    plots before we start modelling."

- Class: cmd_question
  Output: "Look at the top 6 rows of data."
  CorrectAnswer: head(fruit) 
  AnswerTests: omnitest(correctExpr = "head(fruit) ") 
  Hint: head(fruit) 

- Class: text
  Output: "We have four columns of data: `$TAG` is the 
    unique tag number of the tree; `$DBH` is the diameter
    at breast height of the tree (mm); `$FRUIT` is the number
    of fruit counted in each tree; and `$YEAR` is the year."

- Class: cmd_question
  Output: "Look at the structure of the data to get a 
    better idea of how many trees, years, and to check
    that everything is the correct class."
  CorrectAnswer: str(fruit)
  AnswerTests: omnitest(correctExpr = "str(fruit)") 

  Hint: str(fruit)

- Class: cmd_question
  Output: "Now use the `summary()` function to return
    some simple statistics about the data."
  CorrectAnswer: summary(fruit)
  AnswerTests: omnitest(correctExpr = "summary(fruit)") 
  Hint: summary(fruit)

- Class: cmd_question
  Output: "Now look at the distribution of the 
    fruit data. Plot a histogram of `$FRUIT`.
  CorrectAnswer: hist(fruit$FRUIT)
  AnswerTests: omnitest(correctExpr = "hist(fruit$FRUIT)") 
  Hint: hist(fruit$FRUIT)

- Class: text
  Output: "The distribution is definitely skewed, with
    lots of low values. One option, given that we have 
    count data, would be to run a glm with poisson errors.
    However, we want to illustrate the use of `lmer()`,
    and in the 'good ol' days' a regular log-transformation
    would do just fine. The log transform is also one
    of the easier-to-interpret transformations out there."

- Class: cmd_question
  Output: "So, plot another histogram of log(fruit)."
  CorrectAnswer: hist(log(fruit$FRUIT))
  AnswerTests: omnitest(correctExpr = "hist(log(fruit$FRUIT))") 
  Hint: Nest the log of fruit within a call to hist()

- Class: cmd_question
  Output: "That looks much better... so, let's try that in 
    our model. First, we need to make a new column, `$LOGFRUIT`. 
    In the fruit data, make this column of the log of `$fruit`."
  CorrectAnswer: fruit$LOGFRUIT <- log(fruit$FRUIT)
  AnswerTests: omnitest(correctExpr = "fruit$LOGFRUIT <- log(fruit$FRUIT)") 
  Hint: Remember that to create a new column, just call the data object and the new column name, separated by `$`.

- Class: cmd_question
  Output: "Whoa! Wait a second ... what if there are years with 
    no (0) fruit? What would that do? Check it out."
  CorrectAnswer: log(0)
  AnswerTests: omnitest(correctExpr = "log(0)") 
  Hint: take the log of 0.

- Class: cmd_question
  Output: "So the log of 0 is negative infinity.. not a number
    that we can deal with all that easily. Let's make
    sure that there are no 0's in the `$FRUIT` column."
  CorrectAnswer: table(fruit$FRUIT < 1)
  AnswerTests: any_of_expr("table(fruit$FRUIT < 1)", "table(fruit$FRUIT == 0)", "table(fruit$LOGFRUIT == '-Inf')")
  Hint: "There are a number of ways you can do this.. look for `-Inf` in the `$LOGFRUIT` column, 
    check for zeros in the `$FRUIT` column, ... 

- Class: text
  Output: "Phew, we do not have any. However, remember that a way 
    to deal with 0's if you ever need to log-transform data is to 
    add 1 (+1) to the data before you transform it."


- Class: cmd_question
  Output: "Ok, so now let's finally get round to plotting the
    relationship we are interested in and going to model. 
    Plot `$LOGFRUIT` as a function of `$DBH`."
  CorrectAnswer: plot(LOGFRUIT ~ DBH, data = fruit)
  AnswerTests: any_of_expr("plot(LOGFRUIT ~ DBH, data = fruit)", "plot(fruit$LOGFRUIT ~ fruit$DBH)") 
  Hint: Use `plot()` and a formula.

- Class: cmd_question
  Output: "We also have three years of data. Can you colour
     each point as a function of `$YEAR`."
  CorrectAnswer: plot(LOGFRUIT ~ DBH, data = fruit, col = YEAR)
  AnswerTests: any_of_expr("plot(LOGFRUIT ~ DBH, data = fruit, col = YEAR)", "plot(fruit$LOGFRUIT ~ fruit$DBH, col = fruit$YEAR)") 
  Hint: Use `plot()` and a formula, and col = .

- Class: text
  Output: "It looks like there are certainly differences in fruit production 
    among years. We might want to include that explicitly in the 
    model."

- Class: cmd_question
  Output: "However, `$YEAR` in the data is numeric, but 
    we actually want it to be a factor. Create a new column
    in the data called `$YEARFAC` which is `$YEAR` as a factor."
  CorrectAnswer: fruit$YEARFAC <- as.factor(fruit$YEAR)
  AnswerTests: omnitest(correctExpr = "fruit$YEARFAC <- as.factor(fruit$YEAR)") 
  Hint: fruit$YEARFAC <- as.factor(fruit$YEAR)


- Class: cmd_question
  Output: "Now let's run a regular linear regression on these data. 
    Use `lm()` to model log fruit as a function of dbh and year, called `m2`.
  CorrectAnswer: m2 <- lm(LOGFRUIT ~ DBH + YEARFAC, data = fruit)
  AnswerTests: omnitest(correctExpr = "m2 <- lm(LOGFRUIT ~ DBH + YEARFAC, data = fruit)") 
  Hint: m2 <- lm(LOGFRUIT ~ DBH + YEARFAC, data = fruit)

- Class: cmd_question
  Output: "Look at the summary output of m2."
  CorrectAnswer: summary(m2)
  AnswerTests: omnitest(correctExpr = "summary(m2)") 
  Hint: summary(m2)

- Class: text
  Output: "We actually have the same individuals measured in each year
    (i.e., repeated measures). We can account for this issue
    by including individual (i.e., `$TAG`) as a random effect within
    a linear mixed effects model."

- Class: text
  Output: "We used `glmer()` to run a generalised mixed effects
    model on the binomial data. We can use `lmer()` to run 
    a linear mixed effects model on this fruit data. The same
    package, `lme4`, includes this function."

- Class: text
  Output: "However, `lme4` does not calculate p-values, because
    the package authors (eminently sensible people) do not think that there is a reliable
    way to do this: There are various issues with obtaining the degrees of 
    freedom, and thence the F value and p-values."

- Class: text
  Output: "Others (also sensible people) disagree, and have developed various 
    approaches to approximate the degrees of freedom and 
    calculate p-values. One of these can now be done using the 
    `lmer()` function in the package `lmerTest`."

- Class: text
  Output: "When we installed the `lme4` and `lmerTest` packages
    at the beginning of the lesson, the `lmer()` function
    in `lmerTest` overwrote the same function in `lme4`."

- Class: cmd_question
  Output: "Anyway, now you can write the model.
    We construct it in a similar way to before.
    Include `+ (1|TAG)` in the formula to represent the random effect
    of individual tree. Call this model m3"
  CorrectAnswer: m3 <- lmer(LOGFRUIT ~ DBH + YEARFAC + (1|TAG), data = fruit)
  AnswerTests: omnitest(correctExpr = "m3 <- lmer(LOGFRUIT ~ DBH + YEARFAC + (1|TAG), data = fruit)")
  Hint: m3 <- lmer(LOGFRUIT ~ DBH + YEARFAC + (1|TAG), data = fruit)

- Class: text
  Output: "The summary output is similar to that for `glmer()`.
    We have the model formula, residuals, and random effects 
    (showing that there is considerable variation among years
    for any one tree, as well as a lot of unexplained variation
    in fruit production), and the fixed effect coefficient estimates."

- Class: text  
  Output: "For every 1mm increase in DBH, a tree produced 0.004 log fruits
    (or exp(0.004) = c.1 fruit) on average."

- Class: text
  Output: "Year two had generally more fruit than year one,   
    and year three had generally fewer fruit than year one ..."

- Class: text
  Output: "Great! Now you know more than most people about 
    mixed effects models.. but a lot less than you really should
    if you are interested in working with them ;)"

- Class: text
  Output: "So, please do read more on the `lme4` FAQ page: 
    [http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html](
    http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html), 
    and the glmm wiki: [http://glmm.wikidot.com/](http://glmm.wikidot.com/),
    and the references therein."

- Class: text
  Output: "Great work on completing FES720! You are are 
    an R wizard!"

- Class: multiple





