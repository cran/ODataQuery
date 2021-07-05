## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ODataQuery)

## -----------------------------------------------------------------------------
service <- ODataQuery$new("https://services.odata.org/V4/TripPinServiceRW")
service$all()

## -----------------------------------------------------------------------------
people_entity <- service$path("People")

# Get first page
people_entity$retrieve(count=TRUE)

# Get all pages
people_entity$select("UserName", "FirstName", "LastName")$all()

## -----------------------------------------------------------------------------
russellwhyte <- people_entity$get("russellwhyte")
first_person <- people_entity$top(1)$one()
head(first_person)

russellwhyte_friends <- russellwhyte$path("Friends")
russellwhyte_friends$all()

## -----------------------------------------------------------------------------
get_nearest_airport <- service$func('GetNearestAirport')
get_nearest_airport(lat = 33, lon = -118)

## -----------------------------------------------------------------------------
people_query <- people_entity$
  top(5)$
  select('FirstName', 'LastName')$
  filter(Concurrency.gt = 500)$
  expand('Friends($count=true)')$
  orderby('LastName')

people_query$all()

## ----eval=FALSE---------------------------------------------------------------
#  opendata_service <- ODataQuery$new("http://beta-odata4.cbs.nl/")
#  entity_81589NED  <- opendata_service$path("CBS", "81589NED", Observations")
#  dataset_81589NED <- entity_81589NED$all()

## ----eval=FALSE---------------------------------------------------------------
#  northwind_service <- ODataQuery$new("https://services.odata.org/V2/Northwind/Northwind.svc/")
#  customer_entity <- northwind_service$path("Customers")
#  customer_entity$
#    select("CompanyName", "Address", "Phone")$
#    filter(Country.eq = "Germany", City.eq = "Berlin")

## ----eval=FALSE---------------------------------------------------------------
#  denhaag_service <- ODataQuery$new("https://denhaag.incijfers.nl/jiveservices/odata/")
#  denhaag_service$path('DataSources')

