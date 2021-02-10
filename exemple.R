## exemple rapports par région
## Stephane - 10/2/21


##---- mock individual data ----
nregfr <- 18 ## france
ndptfr <- 101
netab <- 4
k <- 3 # nb region
region <- LETTERS[1:k]
set.seed(123)
{
  ndpt_par_region <- rpois(k, ndptfr/nregfr)
  reg <- rep(region, ndpt_par_region)
  dep <- paste0(reg, sequence(ndpt_par_region))
  etab <- paste0("e",1:netab)
  ## all etab in all dpt
  c12 <- expand.grid(dep = dep, etab = etab, stringsAsFactors = FALSE)
  ## some dpt have missing etab type
  nr <- nrow(c12) 
  c12 <- c12[- sample(1:nr, floor(nr/10)),]
  
  df0 <- data.frame(
    region = sub("[0-9]", "", c12[,"dep"]),
    c12,
    x = rpois(nrow(c12),3),
    y = sample(c(NA, 1:9),nrow(c12), replace = TRUE),
    stringsAsFactors = FALSE
  )
}
saveRDS(df0, "mockdataset_ehpad.rds")

##---- summarize function ----
ftab <- function(df){
  aggregate(df[, c("x","y")], 
            list(typ_etab = df$etab), 
            function(x) sum(x, na.rm = TRUE)
  )
}
##---- table France -----
tabfr <- ftab(df0)

##---- table regions ----
ltab <- lapply(setNames(unique(df0$region), unique(df0$region)), function(r){
  ## by region
  dfr <- df0[df0$region == r,]
  tabr <- list(ftab(dfr))
  names(tabr) <- r
  ## by dpt
  ltabd <- lapply(setNames(unique(dfr$dep), unique(dfr$dep)), function(d){
    dfd <- dfr[dfr$dep == d,]
    tabd <- ftab(dfd)
  })
  c(tabr, ltabd)
})
# names(ltab)
saveRDS(ltab, "ltab.rds")

##---- unit report ----
unit_report <- function(reg = "A", fmt = "html"){
    rmarkdown::render(input = "exemple_rapport.Rmd",
                      output_format = paste0(fmt, "_document"),
                      params = list(region = reg),
                      encoding = "UTF-8",
                      output_file = paste0(paste0(Sys.Date(), "_"), 
                                           reg,
                                           ".", fmt) )
  }
# unit_report()
# unit_report(fmt = "pdf")

##---- all reports ----
dummy <- lapply(names(ltab), unit_report)

