Generate reports by region
--------------------------

-   First, we create a mock dataset with
    -   3 *régions*
    -   For each *région* a variable number of *départements*
    -   For each *département*, up to 4 types of *établissements*
        (`typ_etab`), also variable
    -   And two numeric variables (with missing values) to be summarized
        by `typ_etab`
-   It looks like this :

<table>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">region</th>
<th style="text-align: left;">dep</th>
<th style="text-align: left;">etab</th>
<th style="text-align: right;">x</th>
<th style="text-align: right;">y</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">A1</td>
<td style="text-align: left;">e1</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">8</td>
</tr>
<tr class="even">
<td style="text-align: left;">2</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">A2</td>
<td style="text-align: left;">e1</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">8</td>
</tr>
<tr class="odd">
<td style="text-align: left;">4</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">A4</td>
<td style="text-align: left;">e1</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">5</td>
</tr>
<tr class="even">
<td style="text-align: left;">5</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">B1</td>
<td style="text-align: left;">e1</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">4</td>
</tr>
<tr class="odd">
<td style="text-align: left;">6</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">B2</td>
<td style="text-align: left;">e1</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">8</td>
</tr>
<tr class="even">
<td style="text-align: left;">7</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">B3</td>
<td style="text-align: left;">e1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">9</td>
</tr>
<tr class="odd">
<td style="text-align: left;">59</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">B7</td>
<td style="text-align: left;">e4</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">7</td>
</tr>
<tr class="even">
<td style="text-align: left;">60</td>
<td style="text-align: left;">C</td>
<td style="text-align: left;">C1</td>
<td style="text-align: left;">e4</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">61</td>
<td style="text-align: left;">C</td>
<td style="text-align: left;">C2</td>
<td style="text-align: left;">e4</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">6</td>
</tr>
<tr class="even">
<td style="text-align: left;">62</td>
<td style="text-align: left;">C</td>
<td style="text-align: left;">C3</td>
<td style="text-align: left;">e4</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">6</td>
</tr>
<tr class="odd">
<td style="text-align: left;">63</td>
<td style="text-align: left;">C</td>
<td style="text-align: left;">C4</td>
<td style="text-align: left;">e4</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">6</td>
</tr>
<tr class="even">
<td style="text-align: left;">64</td>
<td style="text-align: left;">C</td>
<td style="text-align: left;">C5</td>
<td style="text-align: left;">e4</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">9</td>
</tr>
</tbody>
</table>

-   We want to summarize values by `typ_etab` and this is done with a
    simple function

<!-- -->

    ftab <- function(df){
      aggregate(df[, c("x","y")], 
                list(typ_etab = df$etab), 
                function(x) sum(x, na.rm = TRUE)
      )
    }

-   Now we can look at global results

<table>
<thead>
<tr class="header">
<th style="text-align: left;">typ_etab</th>
<th style="text-align: right;">x</th>
<th style="text-align: right;">y</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">e1</td>
<td style="text-align: right;">47</td>
<td style="text-align: right;">78</td>
</tr>
<tr class="even">
<td style="text-align: left;">e2</td>
<td style="text-align: right;">55</td>
<td style="text-align: right;">71</td>
</tr>
<tr class="odd">
<td style="text-align: left;">e3</td>
<td style="text-align: right;">30</td>
<td style="text-align: right;">67</td>
</tr>
<tr class="even">
<td style="text-align: left;">e4</td>
<td style="text-align: right;">38</td>
<td style="text-align: right;">67</td>
</tr>
</tbody>
</table>

-   Then, for each *région*, we apply `ftab` for the whole region and
    for each *département* within this region. All tables are saved in a
    named list.

<!-- -->

    str(ltab)

    ## List of 3
    ##  $ A:List of 5
    ##   ..$ A :'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 12 19 7 6
    ##   .. ..$ y       : int [1:4] 21 5 16 17
    ##   ..$ A1:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 3 8 2 1
    ##   .. ..$ y       : int [1:4] 8 1 2 9
    ##   ..$ A2:'data.frame':   3 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:3] "e1" "e2" "e3"
    ##   .. ..$ x       : int [1:3] 6 4 1
    ##   .. ..$ y       : int [1:3] 8 0 6
    ##   ..$ A4:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 3 3 2 2
    ##   .. ..$ y       : int [1:4] 5 3 6 3
    ##   ..$ A3:'data.frame':   3 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:3] "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:3] 4 2 3
    ##   .. ..$ y       : int [1:3] 1 2 5
    ##  $ B:List of 8
    ##   ..$ B :'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 17 25 9 17
    ##   .. ..$ y       : int [1:4] 41 35 29 23
    ##   ..$ B1:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 4 3 2 1
    ##   .. ..$ y       : int [1:4] 4 4 5 0
    ##   ..$ B2:'data.frame':   3 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:3] "e1" "e2" "e3"
    ##   .. ..$ x       : int [1:3] 3 2 1
    ##   .. ..$ y       : int [1:3] 8 5 9
    ##   ..$ B3:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 1 1 1 4
    ##   .. ..$ y       : int [1:4] 9 2 4 5
    ##   ..$ B4:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 5 6 2 5
    ##   .. ..$ y       : int [1:4] 3 8 4 2
    ##   ..$ B5:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 2 5 3 2
    ##   .. ..$ y       : int [1:4] 5 3 7 7
    ##   ..$ B6:'data.frame':   3 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:3] "e1" "e2" "e4"
    ##   .. ..$ x       : int [1:3] 0 4 4
    ##   .. ..$ y       : int [1:3] 7 5 2
    ##   ..$ B7:'data.frame':   3 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:3] "e1" "e2" "e4"
    ##   .. ..$ x       : int [1:3] 2 4 1
    ##   .. ..$ y       : int [1:3] 5 8 7
    ##  $ C:List of 6
    ##   ..$ C :'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 18 11 14 15
    ##   .. ..$ y       : int [1:4] 16 31 22 27
    ##   ..$ C1:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 6 0 2 2
    ##   .. ..$ y       : int [1:4] 5 8 2 0
    ##   ..$ C2:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 5 3 5 2
    ##   .. ..$ y       : int [1:4] 6 6 9 6
    ##   ..$ C4:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 4 2 3 3
    ##   .. ..$ y       : int [1:4] 0 7 9 6
    ##   ..$ C5:'data.frame':   4 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:4] "e1" "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:4] 3 2 4 4
    ##   .. ..$ y       : int [1:4] 5 8 1 9
    ##   ..$ C3:'data.frame':   3 obs. of  3 variables:
    ##   .. ..$ typ_etab: chr [1:3] "e2" "e3" "e4"
    ##   .. ..$ x       : int [1:3] 4 0 4
    ##   .. ..$ y       : int [1:3] 2 1 6

-   Finally, elements of the list can be parsed to `exemple_rapport.Rmd`
    to generate a report, individually or for all regions in the list.

-   To generate one report which is saved with time stamp

<!-- -->

     unit_report(reg = "A", verbose = TRUE)

    ## [1] "Output saved to 2021-02-10_A.html"

-   To generate all reports

<!-- -->

    dummy <- lapply(names(ltab), unit_report)
