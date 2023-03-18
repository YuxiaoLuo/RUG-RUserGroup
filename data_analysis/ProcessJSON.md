Process JSON in R
================
Yuxiao Luo
2023-03-17

## Process JSON in R

The JSON data format is designed to allow different machines or systems
to communicate with each other via messages constructed in a well
defined format. JSON is now the most popular and preferred data format
used by APIs (Application Programming Interfaces).

The JSON format is different from the most `.csv` type data, but it’s
still human readable and can also be mapped to an R dataframe/tibble. In
this tutorial, let’s read a file of data in JSON format and convert it a
dataframe in R. Last, we will export the dataframe to a csv file.

We will use a JSON file called `SAFI.json`, which is the output file
from an electronic survey system called ODK. The JSON records the
answers to some survey questions. The unique keys represent each
question while the values are the input answers. I found and stole this
data source from [R for Social
Scientists](https://datacarpentry.org/r-socialsci/07-json/index.html),
many thanks to the author.

### Why we use JSON

There are many advantages of using JSON.

- Popular and common for APIs (e.g., results from an internet search,
  results from Twitter API)
- Human readable
- Documents don’t have to be formatted as strictly the same
  - Each document can have different structure in the same file
  - This is realistic when dealing with raw/unstructured data
  - The document structure is scalable, which means it could be complex
    and nested. It could also be simple and only have few layers in the
    structure.
- Each record (document) is self-contained. The equivalent of the column
  name and column values are in every record.

There are also a few drawbacks.

- It’s more verbose than a `.csv` format data
- It’s less readable than a structured `.csv` data.
- It can be more difficult to process and display than `.csv` data.

### Use JSON package to read JSON file

First, download the `SAFI.json` data from the `data` folder in GitHub
repo to your local desktop. The location of the data in GitHub should be
[here](https://github.com/YuxiaoLuo/RUG-RUserGroup/tree/main/data).

Then, load `jsonlite` package and use `read_json` to read the JSON data.
If you haven’t installed the package, please run
`install.packages('jsonlite')`.

``` r
library(jsonlite)
json_data <- read_json(path = 'data/SAFI.json')
```

As you see, the JSON data is a large list (from the Environment pane)
with 131 elements. If you use `head()` or `View()`, remember to use
`[[index]]` to extract the specific list, otherwise it will show much
more structure, which is hard to read.

``` r
library(tidyverse)
head(json_data[[1]])
```

    ## $C06_rooms
    ## [1] 1
    ## 
    ## $B19_grand_liv
    ## [1] "no"
    ## 
    ## $A08_ward
    ## [1] "ward2"
    ## 
    ## $E01_water_use
    ## [1] "no"
    ## 
    ## $B18_sp_parents_liv
    ## [1] "yes"
    ## 
    ## $B16_years_liv
    ## [1] 4

``` r
head(json_data[[2]])
```

    ## $C06_rooms
    ## [1] 1
    ## 
    ## $B19_grand_liv
    ## [1] "yes"
    ## 
    ## $A08_ward
    ## [1] "ward2"
    ## 
    ## $E01_water_use
    ## [1] "yes"
    ## 
    ## $B18_sp_parents_liv
    ## [1] "yes"
    ## 
    ## $B16_years_liv
    ## [1] 9

Or, we can change the parameter `simplifyVector` in `read_json()` to
simplify nested lists into vectors in JSON. So, let’s set this to `TRUE`
and the data will be read as dataframe.

``` r
jd <- read_json(path = 'data/SAFI.json', simplifyVector = TRUE)
glimpse(jd)
```

    ## Rows: 131
    ## Columns: 74
    ## $ C06_rooms                      <int> 1, 1, 1, 1, 1, 1, 1, 3, 1, 5, 1, 3, 1, …
    ## $ B19_grand_liv                  <chr> "no", "yes", "no", "no", "yes", "no", "…
    ## $ A08_ward                       <chr> "ward2", "ward2", "ward2", "ward2", "wa…
    ## $ E01_water_use                  <chr> "no", "yes", "no", "no", "no", "no", "y…
    ## $ B18_sp_parents_liv             <chr> "yes", "yes", "no", "no", "no", "no", "…
    ## $ B16_years_liv                  <int> 4, 9, 15, 6, 40, 3, 38, 70, 6, 23, 20, …
    ## $ E_yes_group_count              <chr> NA, "3", NA, NA, NA, NA, "4", "2", "3",…
    ## $ F_liv                          <list> [<data.frame[1 x 2]>], [<data.frame[3 …
    ## $ `_note2`                       <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ instanceID                     <chr> "uuid:ec241f2c-0609-46ed-b5e8-fe575f6ce…
    ## $ B20_sp_grand_liv               <chr> "yes", "yes", "no", "no", "no", "no", "…
    ## $ F10_liv_owned_other            <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ `_note1`                       <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ F12_poultry                    <chr> "yes", "yes", "yes", "yes", "yes", "no"…
    ## $ D_plots_count                  <chr> "2", "3", "1", "3", "2", "1", "4", "2",…
    ## $ C02_respondent_wall_type_other <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ C02_respondent_wall_type       <chr> "muddaub", "muddaub", "burntbricks", "b…
    ## $ C05_buildings_in_compound      <int> 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 2, 2, 1, …
    ## $ `_remitters`                   <list> [<data.frame[0 x 0]>], [<data.frame[0 …
    ## $ E18_months_no_water            <list> <NULL>, <"Aug", "Sept">, <NULL>, <NULL…
    ## $ F07_use_income                 <chr> NA, "AlimentaÃ§Ã£o e pagamento de educa…
    ## $ G01_no_meals                   <int> 2, 2, 2, 2, 2, 2, 3, 2, 3, 3, 2, 3, 2, …
    ## $ E17_no_enough_water            <chr> NA, "yes", NA, NA, NA, NA, "yes", "yes"…
    ## $ F04_need_money                 <chr> NA, "no", NA, NA, NA, NA, "no", "no", "…
    ## $ A05_end                        <chr> "2017-04-02T17:29:08.000Z", "2017-04-02…
    ## $ C04_window_type                <chr> "no", "no", "yes", "no", "no", "no", "n…
    ## $ E21_other_meth                 <chr> NA, "no", NA, NA, NA, NA, "no", "no", "…
    ## $ D_no_plots                     <int> 2, 3, 1, 3, 2, 1, 4, 2, 3, 2, 2, 2, 4, …
    ## $ F05_money_source               <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>…
    ## $ A07_district                   <chr> "district1", "district1", "district1", …
    ## $ C03_respondent_floor_type      <chr> "earth", "earth", "cement", "earth", "e…
    ## $ E_yes_group                    <list> [<data.frame[0 x 0]>], [<data.frame[3 …
    ## $ A01_interview_date             <chr> "2016-11-17", "2016-11-17", "2016-11-17…
    ## $ B11_remittance_money           <chr> "no", "no", "no", "no", "no", "no", "no…
    ## $ A04_start                      <chr> "2017-03-23T09:49:57.000Z", "2017-04-02…
    ## $ D_plots                        <list> [<data.frame[2 x 8]>], [<data.frame[3 …
    ## $ F_items                        <list> [<data.frame[3 x 3]>], [<data.frame[2 …
    ## $ F_liv_count                    <chr> "1", "3", "1", "2", "4", "1", "1", "2",…
    ## $ F10_liv_owned                  <list> "poultry", <"oxen", "cows", "goats">, …
    ## $ B_no_membrs                    <int> 3, 7, 10, 7, 7, 3, 6, 12, 8, 12, 6, 7, …
    ## $ F13_du_look_aftr_cows          <chr> "no", "no", "no", "no", "no", "no", "no…
    ## $ E26_affect_conflicts           <chr> NA, "once", NA, NA, NA, NA, "never", "n…
    ## $ F14_items_owned                <list> <"bicycle", "television", "solar_panel…
    ## $ F06_crops_contr                <chr> NA, "more_half", NA, NA, NA, NA, "more_…
    ## $ B17_parents_liv                <chr> "no", "yes", "no", "no", "yes", "no", "…
    ## $ G02_months_lack_food           <list> "Jan", <"Jan", "Sept", "Oct", "Nov", "…
    ## $ A11_years_farm                 <dbl> 11, 2, 40, 6, 18, 3, 20, 16, 16, 22, 6,…
    ## $ F09_du_labour                  <chr> "no", "no", "yes", "yes", "no", "yes", …
    ## $ E_no_group_count               <chr> "2", NA, "1", "3", "2", "1", NA, NA, NA…
    ## $ E22_res_change                 <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>…
    ## $ E24_resp_assoc                 <chr> NA, "no", NA, NA, NA, NA, NA, "yes", NA…
    ## $ A03_quest_no                   <chr> "01", "01", "03", "04", "05", "6", "7",…
    ## $ `_members`                     <list> [<data.frame[3 x 12]>], [<data.frame[7…
    ## $ A06_province                   <chr> "province1", "province1", "province1", …
    ## $ `gps:Accuracy`                 <dbl> 14, 19, 13, 5, 10, 12, 11, 9, 11, 14, 1…
    ## $ E20_exper_other                <chr> NA, "yes", NA, NA, NA, NA, "yes", "yes"…
    ## $ A09_village                    <chr> "village2", "village2", "village2", "vi…
    ## $ C01_respondent_roof_type       <chr> "grass", "grass", "mabatisloping", "mab…
    ## $ `gps:Altitude`                 <dbl> 698, 690, 674, 679, 689, 692, 709, 700,…
    ## $ `gps:Longitude`                <dbl> 33.48346, 33.48342, 33.48345, 33.48342,…
    ## $ E23_memb_assoc                 <chr> NA, "yes", NA, NA, NA, NA, "no", "yes",…
    ## $ E19_period_use                 <dbl> NA, 2, NA, NA, NA, NA, 10, 10, 6, 22, N…
    ## $ E25_fees_water                 <chr> NA, "no", NA, NA, NA, NA, "no", "no", "…
    ## $ C07_other_buildings            <chr> "no", "no", "no", "no", "no", "no", "ye…
    ## $ observation                    <chr> "None", "Estes primeiros inquÃ©ritos na…
    ## $ `_note`                        <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ A12_agr_assoc                  <chr> "no", "yes", "no", "no", "no", "no", "n…
    ## $ G03_no_food_mitigation         <list> <"na", "rely_less_food", "reduce_meals…
    ## $ F05_money_source_other         <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ `gps:Latitude`                 <dbl> -19.11226, -19.11248, -19.11211, -19.11…
    ## $ E_no_group                     <list> [<data.frame[2 x 6]>], [<data.frame[0 …
    ## $ F14_items_owned_other          <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ F08_emply_lab                  <chr> "no", "yes", "no", "no", "no", "no", "n…
    ## $ `_members_count`               <chr> "3", "7", "10", "7", "7", "3", "6", "12…

Looking at the column description, we find some columns are list type
and dataframes are included in there. For example, `F_liv` is a list of
dataframes. To look into the column of lists, we first extract the
column and then extract the list using `[[index]]`. For example, the
`F_liv` column list in the data contains 131 dataframes.

``` r
length(jd$F_liv)
```

    ## [1] 131

We can extract a dataframe in the column list.

``` r
jd$F_liv[[1]]
```

    ##   F11_no_owned F_curr_liv
    ## 1            1    poultry

You can also try to convert this specific list of dataframes into a
2-column table to better look through the information.

``` r
as.data.frame(as.matrix(unlist(jd$F_liv))) %>% head()
```

    ##                    V1
    ## F11_no_owned        1
    ## F_curr_liv    poultry
    ## F11_no_owned1       4
    ## F11_no_owned2       3
    ## F11_no_owned3       4
    ## F_curr_liv1      oxen

For each column that is list of dataframes, you need to convert it
individually. With the data frame, we can use filter features to wrangle
the data. Let’s first create a column from the row names.

``` r
jd_liv <- as.data.frame(as.matrix(unlist(jd$F_liv)))
jd_liv <- as.data.frame(jd_liv) %>% rename(A = V1) %>% 
  rownames_to_column(var = "Q") 
```

Assume we want to find all `F11_no_owned` with the value of 4. Let’s
return the first 5 rows.

``` r
jd_liv %>% filter(if_any(Q, ~str_detect(.,"F11_no_owned")), 
                  A == 4) %>% head(5)
```

    ##                 Q A
    ## 1   F11_no_owned1 4
    ## 2   F11_no_owned3 4
    ## 3 F11_no_owned2.1 4
    ## 4 F11_no_owned2.2 4
    ## 5 F11_no_owned2.8 4

Assume we want to find all `F_curr_liv` with the value of cows.

``` r
jd_liv %>% filter(if_any(Q, ~str_detect(., "F_curr_liv")),
                  A == "cows") %>% head(5)
```

    ##               Q    A
    ## 1   F_curr_liv2 cows
    ## 2 F_curr_liv2.1 cows
    ## 3 F_curr_liv2.2 cows
    ## 4 F_curr_liv2.4 cows
    ## 5 F_curr_liv2.5 cows

#### Write JSON file to csv

Notice that since some columns are lists of dataframes, if we want to
convert JSON to csv. We will need to change these columns from list type
to character type.

``` r
flatten_json <- apply(jd, 2, as.character) %>% as_tibble()
head(flatten_json)
```

    ## # A tibble: 6 × 74
    ##   C06_ro…¹ B19_g…² A08_w…³ E01_w…⁴ B18_s…⁵ B16_y…⁶ E_yes…⁷ F_liv _note…⁸ insta…⁹
    ##   <chr>    <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr> <chr>   <chr>  
    ## 1 1        no      ward2   no      yes     4       <NA>    "lis… NA      uuid:e…
    ## 2 1        yes     ward2   yes     yes     9       3       "lis… NA      uuid:0…
    ## 3 1        no      ward2   no      no      15      <NA>    "lis… NA      uuid:1…
    ## 4 1        no      ward2   no      no      6       <NA>    "lis… NA      uuid:1…
    ## 5 1        yes     ward2   no      no      40      <NA>    "lis… NA      uuid:2…
    ## 6 1        no      ward2   no      no      3       <NA>    "lis… NA      uuid:d…
    ## # … with 64 more variables: B20_sp_grand_liv <chr>, F10_liv_owned_other <chr>,
    ## #   `_note1` <chr>, F12_poultry <chr>, D_plots_count <chr>,
    ## #   C02_respondent_wall_type_other <chr>, C02_respondent_wall_type <chr>,
    ## #   C05_buildings_in_compound <chr>, `_remitters` <chr>,
    ## #   E18_months_no_water <chr>, F07_use_income <chr>, G01_no_meals <chr>,
    ## #   E17_no_enough_water <chr>, F04_need_money <chr>, A05_end <chr>,
    ## #   C04_window_type <chr>, E21_other_meth <chr>, D_no_plots <chr>, …

Then, we can write this flattened dataframe to csv file.

``` r
write_csv(flatten_json, file = "output/JSON_to_CSV.csv")
```

When you try to read this csv into R again, the column of the nested
dataframes are character/string now. And now is hard to reverse it back
to dataframes. So I highly recommend you to store a copy of the data in
the original JSON format. Or you store each nested dataframes to a csv
like the code shows below.

``` r
write_csv(jd$F_liv[[3]], file = "output/F_liv_to_csv.csv")
```

There is another package can deal with `JSON` in R called
[tidyjson](https://cran.microsoft.com/snapshot/2017-08-01/web/packages/tidyjson/vignettes/introduction-to-tidyjson.html).
Let’s explore it next time.

### Reference

- [R for Social Data
  Scientist](https://datacarpentry.org/r-socialsci/07-json/index.html)
