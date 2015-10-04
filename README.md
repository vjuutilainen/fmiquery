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

Sample output:

```
    fmisid                name       time  tday  tmin tmax rain snow
1   100971 Helsinki Kaisaniemi 2015-01-01   3.4   1.9  5.1  0.9    3
2   100971 Helsinki Kaisaniemi 2015-01-02   4.2   3.7  6.0  3.4   -1
3   100971 Helsinki Kaisaniemi 2015-01-03   1.8   0.9  4.1  1.5   -1
4   100971 Helsinki Kaisaniemi 2015-01-04  -1.6  -2.0  1.0  0.1   -1
5   100971 Helsinki Kaisaniemi 2015-01-05  -8.8 -11.4 -1.1 -1.0   -1
```
