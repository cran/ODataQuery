## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ODataQuery)
service <- ODataQuery$new("https://services.odata.org/V4/TripPinServiceRW")
people_entity <- service$path("People")

## -----------------------------------------------------------------------------
people_entity$filter("Concurrency gt 500")
people_entity$filter("Friends/any(f: f/FirstName eq 'John')")

## -----------------------------------------------------------------------------
people_entity$filter(Concurrency.gt = 500)
people_entity$filter(or_query(Concurrency.lt = 500, Concurrency.gt = 1500))

## -----------------------------------------------------------------------------
people_entity$filter(to_odata(Concurrency > 500))
name <- 'John'
people_entity$filter(to_odata(Friends$any(f ~ f$FirstName == !!name)))

