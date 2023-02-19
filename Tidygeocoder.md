Intro to Geocoding in R
================
Yuxiao Luo
2023-02-15

## Concept

### Geocoding

What is the meaning of geocoding? Geocoding is the process of
transforming a description of a location—such as a pair of coordinates,
an address, or a name of a place—to a location on the earth’s surface.
You can geocode by entering one location description at a time or by
providing many of them at once in a table.

### Reverse-geocoding

Reverse geocoding is a way to convert latitude and longitude coordinates
to addresses. It’s the opposite of geocoding which lets you find
latitude and longitude by address. All kinds of companies use reverse
geocoding to find accurate address data for things like delivery
updates, location-based advertising, or as part of an address
verification solution.

We can use the`tidygeocoder` package in R to do both work.

## Code Demo

### Geocoding

First, let’s install the package and load it into R environment.

``` r
# install the package if you don't have it
# install.packages('tidygeocoder')
library(tidygeocoder)
library(tidyverse)
```

Create a dataframe with addresses

``` r
addresses <- tibble::tribble(
~name,                  ~addr,
"White House",          "1600 Pennsylvania Ave NW, Washington, DC",
"Transamerica Pyramid", "600 Montgomery St, San Francisco, CA 94111",     
"Willis Tower",         "233 S Wacker Dr, Chicago, IL 60606"                                  
)
addresses
```

    ## # A tibble: 3 × 2
    ##   name                 addr                                      
    ##   <chr>                <chr>                                     
    ## 1 White House          1600 Pennsylvania Ave NW, Washington, DC  
    ## 2 Transamerica Pyramid 600 Montgomery St, San Francisco, CA 94111
    ## 3 Willis Tower         233 S Wacker Dr, Chicago, IL 60606

Geocode the addresses

``` r
# geocode the addresses
lat_longs <- addresses %>%
  geocode(addr, method = 'osm', lat = latitude , long = longitude)
lat_longs
```

    ## # A tibble: 3 × 4
    ##   name                 addr                                      latit…¹ longi…²
    ##   <chr>                <chr>                                       <dbl>   <dbl>
    ## 1 White House          1600 Pennsylvania Ave NW, Washington, DC     38.9   -77.0
    ## 2 Transamerica Pyramid 600 Montgomery St, San Francisco, CA 941…    37.8  -122. 
    ## 3 Willis Tower         233 S Wacker Dr, Chicago, IL 60606           41.9   -87.6
    ## # … with abbreviated variable names ¹​latitude, ²​longitude

### Reverse Geocoding

To do reverse geocoding, we need geolocation coordinates (latitude and
longitude). And then we can find the address and assoicated details of
that address. I downloaded the crime reports in NYC from the [NYC Open
Data webiste](https://opendata.cityofnewyork.us/), and subset 5
observations from the large dataset. I anonymized the data by replacing
the original complaint ID with a randomly generated ID for each report
and removing the dates. First, let’s load the data into R environment
and take a look at it.
