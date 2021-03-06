check\_reverse\_dependencies
================

``` r
library("prrd")
td <- tempdir()
package = "vtreat"
packageVersion(package)
```

    ## [1] '1.6.2'

``` r
date()
```

    ## [1] "Sat Oct 17 08:10:38 2020"

``` r
parallelCluster <- NULL
# # parallel doesn't work due to https://github.com/r-lib/liteq/issues/22
#ncores <- parallel::detectCores()
#parallelCluster <- parallel::makeCluster(ncores)

orig_dir <- getwd()
print(orig_dir)
```

    ## [1] "/Users/johnmount/Documents/work/vtreat/extras"

``` r
setwd(td)
print(td)
```

    ## [1] "/var/folders/7f/sdjycp_d08n8wwytsbgwqgsw0000gn/T//RtmpDAVlQY"

``` r
options(repos = c(CRAN="https://cloud.r-project.org"))
jobsdfe <- enqueueJobs(package=package, directory=td)

mk_fn <- function(package, directory) {
  force(package)
  force(directory)
  function(i) {
    library("prrd")
    setwd(directory)
    Sys.sleep(1*i)
    dequeueJobs(package=package, directory=directory)
  }
}
f <- mk_fn(package=package, directory=td)

if(!is.null(parallelCluster)) {
  parallel::parLapply(parallelCluster, seq_len(ncores), f)
} else {
  f(0)
}
```

    ## ## Reverse depends check of vtreat 1.6.2 
    ## crispRdesignR_1.1.5 started at 2020-10-17 08:10:39 success at 2020-10-17 08:11:03 (1/0/0)

    ## [1] id     title  status
    ## <0 rows> (or 0-length row.names)

``` r
summariseQueue(package=package, directory=td)
```

    ## Test of vtreat 1.6.2 had 1 successes, 0 failures, and 0 skipped packages. 
    ## Ran from 2020-10-17 08:10:39 to 2020-10-17 08:11:03 for 24 secs 
    ## Average of 24 secs relative to 23.965 secs using 1 runners
    ## 
    ## Failed packages:   
    ## 
    ## Skipped packages:   
    ## 
    ## None still working
    ## 
    ## None still scheduled

``` r
setwd(orig_dir)
if(!is.null(parallelCluster)) {
  parallel::stopCluster(parallelCluster)
}
```
