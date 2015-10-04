# FMI Query

Get data from FMI (Finnish Meteorological Institute) stored queries.

## Usage
Assuming [devtools](https://github.com/hadley/devtools) is installed:

```r
install_github('vjuutilainen/fmiquery')
require('fmiquery')

key <- 'yourapikey'
fmisid <- '100971' # Kaisaniemi
year <- '2015'

data <- daily_obs(key, fmisid, year)
```
