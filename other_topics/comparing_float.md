Comparing Floating Point Numbers
================
Yuxiao Luo
2023-02-22

## Floating Trap

### Answer this Question

First, think about this problem: what’s the result of `.3/3 == .1`. If
your answer is `TRUE`, then it’s necessary for you to read this
tutorial. The correct answer should be:

``` r
(.3/.1) == 3
```

    ## [1] FALSE

Let’s start from the bottom.

### What is Floating Point Number

There are usually 2 types of numbers in all kinds of programming
languages, one is integer, the other is called floating point. Floating
point is used to represent fractional values (or values with decimals).

Floating-point number formats include double-precision format and
single-precision format.

- Single-precision occupies 32 bits in computer memory.
- Double-precision occupies 64 bits in computer memory.

For more information about the concepts, you can check out [Wikipedia
page](https://en.wikipedia.org/wiki/Double-precision_floating-point_format).

As suggested, double precision may be chosen when the range or precision
of single precision would be insufficient. But R doesn’t have single
precision type. That’s the reason why you see R is returning `double`
when you check the type of number using `typeof()` in R. For example,

``` r
typeof(0.5)
```

    ## [1] "double"

You should know that floats should use about half as much memory as
doubles. But the sacrifice is the accuracy, which many statisticians
don’t like. If you think your data is well-conditioned, using floats
could be suitable then.

We will not get involved in the debate of which one is better. I just
wanted to say being a business (information systems specialization)
researcher, I use the default (double) in R all the time to deal with
floating point numbers. What I would focus in this tutorial is how to
compare floating point numbers (by default, double-precision type) in R
as this is a usual error in numerical methods. It’s listed as the first
topic called the floating trap in [*The R
Inferno*](https://www.burns-stat.com/pages/Tutor/R_inferno.pdf), which
is good book by the way.

### Work with Float in R

If you want to work with `float` in R, I recommend you read this
introduction of package
[`float`](https://cran.r-project.org/web/packages/float/readme/README.html#:~:text=float%20is%20a%20single%20precision,obvious%20performance%20vs%20accuracy%20tradeoff.),
in which there is nice an instruction to get started. Please remember to
install single precision BLAS/LAPACK routines before you use `float`
(the instruction suggests [Microsoft R
Open](https://mran.microsoft.com/open)). Otherwise, you may not obtain
that speed enhancement.

### Comparing Floats

The issue of comparing floats results from the binary representation of
decimal numbers. One option is you can use the `all.equal` function.

``` r
all.equal(.3/.1, 3, tolerance = sqrt(.Machine$double.eps))
```

    ## [1] TRUE

You see that, with tolerance of very very tiny error, two values are
nearly equal. The tolerance is set up by
`tolerance = sqrt(.Machine$double.eps)`.

The other option is that the `fpCompare` package offers relational
operators to compare floats with a set tolerance. Let’s install the
package and load it in the environment.

``` r
# install from CRAN
# install.packages("fpCompare")
library(fpCompare)
```

Let’s compare floats using relational operators. Here is a list:

- b%\<=%a (b \<= a)
- b%\<\<%a (b \< a)
- b%\>\>%a (b \> a)
- b%==%a (b == a)
- b%!=%a (b != a)

This is without relation operator:

``` r
.3/.1 == 3 
```

    ## [1] FALSE

Now, you see the expected result. These two values are nearly equal, but
not truly equal in machines.

``` r
(.3/.1) %==% 3
```

    ## [1] TRUE

Notice that, we can change the tolerance value based on our needs by
setting `fpCompare.tolerance`, in `options`. This is using the same
default tolerance value (`.Machine$double.eps^.5`, which is
`0.00000001490116`) used in `all.equal()` for numeric comparisons.

``` r
tol = .Machine$double.eps^.5 # default value
options(fpCompare.tolerance = tol)

# run the comparison again with tolerance
(.3/.1) %==% 3
```

    ## [1] TRUE

Try another example:

``` r
(0.5-0.3) %==% (0.3-0.1)
```

    ## [1] TRUE

Last tip, sometimes you see scientific notation in R and want to avoid
it. You can use the `scipen` argument in `options`. Decreasing the value
of `scipen` will cause R to switch to scientific notation for larger
numbers. Default is `scipen = 0`.

``` r
options(scipen = 4)
print(.Machine$double.eps^.5)
```

    ## [1] 0.00000001490116

``` r
options(scipen = 3)
print(.Machine$double.eps^.5)
```

    ## [1] 1.490116e-08

That’s it. Hope you enjoyed this article.

## References

- [Machine
  Characteristics](https://www.math.ucla.edu/~anderson/rw1001/library/base/html/zMachine.html)

- [fpCompare](https://fpcompare.predictiveecology.org/)

- [The R Inferno (Burns, Patrick.
  2012)](https://www.burns-stat.com/pages/Tutor/R_inferno.pdf)

- [What every computer scientist should know about floating-point
  arithmetic (Goldberg, David.
  1991)](https://dl.acm.org/doi/10.1145/103162.103163)
