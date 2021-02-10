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
    for each *département* within this *région*. All tables are saved in
    a named list.

-   Finally, elements of the list can be parsed to `exemple_rapport.Rmd`
    to generate a report, individually or for all regions in the list.

-   Exemple of one report:

<!-- -->

    ## 
    ## 
    ## processing file: exemple_rapport.Rmd

    ##   |                                                                              |                                                                      |   0%  |                                                                              |..........                                                            |  14%
    ##    inline R code fragments
    ## 
    ##   |                                                                              |....................                                                  |  29%
    ## label: unnamed-chunk-5 (with options) 
    ## List of 1
    ##  $ include: logi FALSE
    ## 
    ##   |                                                                              |..............................                                        |  43%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |........................................                              |  57%
    ## label: unnamed-chunk-6 (with options) 
    ## List of 1
    ##  $ echo: logi FALSE
    ## 
    ##   |                                                                              |..................................................                    |  71%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |............................................................          |  86%
    ## label: unnamed-chunk-7 (with options) 
    ## List of 2
    ##  $ echo   : logi FALSE
    ##  $ results: chr "asis"
    ## 
    ##   |                                                                              |......................................................................| 100%
    ##   ordinary text without R code

    ## output file: exemple_rapport.knit.md

    ## "C:/Users/s.levu/Documents/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS exemple_rapport.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output 2021-02-10_A.html --email-obfuscation none --self-contained --standalone --section-divs --template "C:\Users\s.levu\Documents\R\R-3.6.2\library\rmarkdown\rmd\h\default.html" --no-highlight --variable highlightjs=1 --variable "theme:bootstrap" --include-in-header "C:\Users\S329F~1.LEV\AppData\Local\Temp\RtmpMdCJ2o\rmarkdown-str2198280c4950.html" --mathjax --variable "mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" --lua-filter "C:/Users/s.levu/Documents/R/R-3.6.2/library/rmarkdown/rmd/lua/pagebreak.lua" --lua-filter "C:/Users/s.levu/Documents/R/R-3.6.2/library/rmarkdown/rmd/lua/latex-div.lua"

    ## 
    ## Output created: 2021-02-10_A.html
