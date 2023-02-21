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
```

This is the look of the `addresses` data
frame/[tibble](https://tibble.tidyverse.org/).

``` r
addresses
```

    ## # A tibble: 3 × 2
    ##   name                 addr                                      
    ##   <chr>                <chr>                                     
    ## 1 White House          1600 Pennsylvania Ave NW, Washington, DC  
    ## 2 Transamerica Pyramid 600 Montgomery St, San Francisco, CA 94111
    ## 3 Willis Tower         233 S Wacker Dr, Chicago, IL 60606

Geocode the addresses using `geocode` function. The returned message
from the API query contains many columns, including class of the
address, type of the address, license information, and coordinates.
Let’s extract the latitudes and longitude in the return message with
`lat = latitude` and `long = longtitude`.

``` r
# geocode the addresses
lat_longs <- addresses %>%
  geocode(addr, method = 'osm', lat = latitude , long = longitude)

# this result only returns latitudes and longitudes
lat_longs
```

    ## # A tibble: 3 × 4
    ##   name                 addr                                      latit…¹ longi…²
    ##   <chr>                <chr>                                       <dbl>   <dbl>
    ## 1 White House          1600 Pennsylvania Ave NW, Washington, DC     38.9   -77.0
    ## 2 Transamerica Pyramid 600 Montgomery St, San Francisco, CA 941…    37.8  -122. 
    ## 3 Willis Tower         233 S Wacker Dr, Chicago, IL 60606           41.9   -87.6
    ## # … with abbreviated variable names ¹​latitude, ²​longitude

If you need more information from the address that is provided from the
API serivce, you can use the argument `full_results = TRUE`. Notice that
the address details may vary from different API, which is the
`method = 'osm'` argument you specify in the function.

``` r
full_result <- addresses %>% geocode(addr, method = 'osm', full_results = TRUE)
# overview of the returned full results
glimpse(full_result)
```

    ## Rows: 3
    ## Columns: 14
    ## $ name         <chr> "White House", "Transamerica Pyramid", "Willis Tower"
    ## $ addr         <chr> "1600 Pennsylvania Ave NW, Washington, DC", "600 Montgome…
    ## $ lat          <dbl> 38.89770, 37.79520, 41.87887
    ## $ long         <dbl> -77.03655, -122.40279, -87.63591
    ## $ place_id     <int> 164605957, 110070947, 119999324
    ## $ licence      <chr> "Data © OpenStreetMap contributors, ODbL 1.0. https://osm…
    ## $ osm_type     <chr> "way", "way", "way"
    ## $ osm_id       <int> 238241022, 24222973, 58528804
    ## $ boundingbox  <list> <"38.8974908", "38.897911", "-77.0368537", "-77.0362519">…
    ## $ display_name <chr> "White House, 1600, Pennsylvania Avenue Northwest, Washin…
    ## $ class        <chr> "office", "tourism", "building"
    ## $ type         <chr> "government", "attraction", "commercial"
    ## $ importance   <dbl> 1.054721, 1.139861, 1.224511
    ## $ icon         <chr> NA, "https://nominatim.openstreetmap.org/ui/mapicons/poi_…

In the returned full results (14 columns), you can see extra address
information other than the coordinates.

There are many geocoding services you can choose. Here is a [full
list](https://jessecambon.github.io/tidygeocoder/articles/geocoder_services.html)
of the services offered in `tidygeocoder`. I tested with `osm`
(OpenStreetMap provided by Nominatim API), `ArcGIS` (ArcGIS) and `Bing`
(Microsoft Bing Map), and here is my feedback:

- `osm` can return complete and reliable result, the speed limit is 1
  query per second. It doesn’t need API key.

- `ArcGIS` can return the primary results in a fast and more efficient
  manner, but some information might be missing, ex., postal code.
  However, it doesn’t have any usage limitation as far as I know. It
  doesn’t require an API key either.

- `Bing` can return complete and reliable result with a nice speed. It
  needs [registration](https://www.bingmapsportal.com/) and requires API
  key. It offers a free quota for trial usage (30000 queries). However,
  if you are working on a research project in a university or use the
  API queries for educational purpose, you can apply for education
  license, which will give you 30000 queries per day. You can find the
  instruction and email address in the Bing Developer Portal for
  applying to eudcational license after you register with the link
  above.

### Reverse Geocoding

To do reverse geocoding, we need geolocation coordinates (latitude and
longitude). And then we can find the address and assoicated details of
that address.

I downloaded the crime reports in NYC from the [NYC Open Data
webiste](https://opendata.cityofnewyork.us/), and subset 5 observations
from the large dataset. I anonymized the data by replacing the original
complaint ID with a randomly generated ID for each report and removing
the dates.

First, let’s load the data into R environment. We can load it from the
RUG GitHub folder.

``` r
address <- read_csv('https://raw.githubusercontent.com/YuxiaoLuo/RUG-RUserGroup/main/data/address.csv')
```

Let’s glimpse the data. OFNS_DESC is the offense description. PD_DESC is
the police department standard description of the crime. We will use the
**Latitude** and **Longitude** to obtain the detailed address.

``` r
glimpse(address)
```

    ## Rows: 5
    ## Columns: 5
    ## $ id        <dbl> 478325, 478326, 478327, 478328, 478329
    ## $ OFNS_DESC <chr> "GRAND LARCENY", "HARRASSMENT 2", "PETIT LARCENY", "CRIMINAL…
    ## $ PD_DESC   <chr> "LARCENY,GRAND BY IDENTITY THEFT-UNCLASSIFIED", "HARASSMENT,…
    ## $ Latitude  <dbl> 40.73683, 40.66779, 40.74126, 40.71443, 40.72780
    ## $ Longitude <dbl> -73.98875, -73.90587, -73.81912, -73.91424, -73.97923

Reverse geocoding uses `reverse_geocode` function. You need to specify
the latitude and longitude columns for the arguments `lat` and `long`.
And specify the which API service you will use in `method` argument,
here I’m using `osm`.

``` r
address_osm <- reverse_geocode(address, 
                               lat = Latitude, 
                               long = Longitude, 
                               method = 'osm')
glimpse(address_osm)
```

    ## Rows: 5
    ## Columns: 6
    ## $ id        <dbl> 478325, 478326, 478327, 478328, 478329
    ## $ OFNS_DESC <chr> "GRAND LARCENY", "HARRASSMENT 2", "PETIT LARCENY", "CRIMINAL…
    ## $ PD_DESC   <chr> "LARCENY,GRAND BY IDENTITY THEFT-UNCLASSIFIED", "HARASSMENT,…
    ## $ Latitude  <dbl> 40.73683, 40.66779, 40.74126, 40.71443, 40.72780
    ## $ Longitude <dbl> -73.98875, -73.90587, -73.81912, -73.91424, -73.97923
    ## $ address   <chr> "213, Park Avenue South, Manhattan Community Board 5, Manhat…

The result will return the address associated with the coordinates. If
you want more details with the address. You can specify
`full_result = TRUE`.

``` r
address_osm_full <- reverse_geocode(address, Latitude, Longitude, method = 'osm', full_results = TRUE)
glimpse(address_osm_full)
```

    ## Rows: 5
    ## Columns: 24
    ## $ id               <dbl> 478325, 478326, 478327, 478328, 478329
    ## $ OFNS_DESC        <chr> "GRAND LARCENY", "HARRASSMENT 2", "PETIT LARCENY", "C…
    ## $ PD_DESC          <chr> "LARCENY,GRAND BY IDENTITY THEFT-UNCLASSIFIED", "HARA…
    ## $ Latitude         <dbl> 40.73683, 40.66779, 40.74126, 40.71443, 40.72780
    ## $ Longitude        <dbl> -73.98875, -73.90587, -73.81912, -73.91424, -73.97923
    ## $ address          <chr> "213, Park Avenue South, Manhattan Community Board 5,…
    ## $ place_id         <int> 168178290, 167543808, 174392047, 167576877, 168170242
    ## $ licence          <chr> "Data © OpenStreetMap contributors, ODbL 1.0. https:/…
    ## $ osm_type         <chr> "way", "way", "way", "way", "way"
    ## $ osm_id           <int> 249657335, 249544986, 284492649, 250451993, 249657796
    ## $ osm_lat          <chr> "40.7367253", "40.667945200000005", "40.7412718", "40…
    ## $ osm_lon          <chr> "-73.98848375618527", "-73.9059354", "-73.81881304999…
    ## $ house_number     <chr> "213", "363", "59-21", "52-20", "186"
    ## $ road             <chr> "Park Avenue South", "Sutter Avenue", "150th Street",…
    ## $ neighbourhood    <chr> "Manhattan Community Board 5", "Brownsville", NA, "Ri…
    ## $ suburb           <chr> "Manhattan", "Brooklyn", "Queens", "Queens", "Manhatt…
    ## $ county           <chr> "New York County", NA, NA, NA, "New York County"
    ## $ city             <chr> "City of New York", "City of New York", "City of New …
    ## $ state            <chr> "New York", "New York", "New York", "New York", "New …
    ## $ `ISO3166-2-lvl4` <chr> "US-NY", "US-NY", "US-NY", "US-NY", "US-NY"
    ## $ postcode         <chr> "10003", "11212", "11355", "11378", "10009"
    ## $ country          <chr> "United States", "United States", "United States", "U…
    ## $ country_code     <chr> "us", "us", "us", "us", "us"
    ## $ boundingbox      <list> <"40.7366331", "40.7368174", "-73.9886512", "-73.9883…

I can extract whatever information I need in the full results. For
example, I need the county, city, and postcode of the coordinates.

``` r
address_osm_full_subset <- address_osm_full %>% select(id, county, city, postcode)
address_osm_full_subset 
```

    ## # A tibble: 5 × 4
    ##       id county          city             postcode
    ##    <dbl> <chr>           <chr>            <chr>   
    ## 1 478325 New York County City of New York 10003   
    ## 2 478326 <NA>            City of New York 11212   
    ## 3 478327 <NA>            City of New York 11355   
    ## 4 478328 <NA>            City of New York 11378   
    ## 5 478329 New York County City of New York 10009

### API key

If you have a large amount of geocoding queries, I would recommend to
use any of service that requires API key since it’s providing a stable
and fast service. Assume you’ve registered any of the service and
obtained an API key. You can set up the API key in `Sys.setenv()` by
replacing `***Your API key***` with your own unique key (a series of
digits and letters). Please keep your API key in a secret and a safe
place.

``` r
Sys.setenv(HERE_API_KEY = '***Your API key***')
```

And then when you run `geocode` or `reverse_geocode` functions, choose
the corresponding API service method. For example, I’m assuming you are
using Google API service, then you should use `method = 'google'`.

``` r
geocode(some_addresses, address = addr, method = 'google', lat = latitude, long = longitude)
```

That’s it. I hope you enjoyed reading this tutorial for Geocoding in R.
