# FMI Query

Construct a data frame from FMI (Finnish Meteorological Institute) daily observations for a specified year. This package is based on Daily Weather Observations (fmi::observations::weather::daily::timevaluepair). More info about [FMI Open data WFS services](http://en.ilmatieteenlaitos.fi/open-data-manual-fmi-wfs-services).

## Usage
Assuming you have installed [devtools](https://github.com/hadley/devtools) and [registered to FMI Open data services](https://ilmatieteenlaitos.fi/rekisteroityminen-avoimen-datan-kayttajaksi):

```r
install_github('vjuutilainen/fmiquery')
require('fmiquery')

key <- 'yourapikey'
fmisid <- '100971' # Kaisaniemi
year <- '2015'

data <- daily_obs(key, fmisid, year)
```
