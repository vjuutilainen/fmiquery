#' Get data from FMI (Finnish Meteorological Institute) stored queries.
#'
#' @param key FMI API-key
#' @param fmisid Weather station id (FMISID)
#' @param year Observation year
#' @return data frame containing fmisid, name, time, tday, tmin, tmax, rain and snow columns
#' @export
#' @examples
#' daily_obs('yourapikey', '100971', '2015')

daily_obs = function(key, fmisid, year) {

  starttime <- paste(year, '-01-01', sep='')
  endtime <- paste(year, '-12-31', sep='')

  storedquery_id <- 'fmi::observations::weather::daily::timevaluepair'
  parameters <- 'tday,tmin,tmax,rrday,snow'

  url <- paste('http://data.fmi.fi/fmi-apikey/', key,
                '/wfs?request=getFeature&storedquery_id=', storedquery_id,
                '&crs=EPSG::3067&fmisid=', fmisid,
                '&starttime=', starttime,
                '&endtime=', endtime,
                '&parameters=', parameters,
                sep='')

  xml <- read_xml(url)

  # Check from time if there is data, otherwise return NULL
  time <- xml_find_all(xml,'//wfs:member[1]//wml2:time', xml_ns(xml))

  if(length(time) == 0) {
    return(NULL)
  }

  time <- sapply(time, xml_text) %>%
          as.POSIXlt(format='%Y-%m-%d', tz='')

  tday <- xml_find_all(xml, '//wfs:member[1]//wml2:value', xml_ns(xml)) %>%
          sapply(xml_text) %>%
          as.numeric()

  tmin <- xml_find_all(xml, '//wfs:member[2]//wml2:value', xml_ns(xml)) %>%
          sapply(xml_text) %>%
          as.numeric()

  tmax <- xml_find_all(xml, '//wfs:member[3]//wml2:value', xml_ns(xml)) %>%
          sapply(xml_text) %>%
          as.numeric()

  rain <- xml_find_all(xml, '//wfs:member[4]//wml2:value', xml_ns(xml)) %>%
          sapply(xml_text) %>%
          as.numeric()

  snow <- xml_find_all(xml, '//wfs:member[5]//wml2:value', xml_ns(xml)) %>%
          sapply(xml_text) %>%
          as.numeric()

  name <- xml_find_all(xml, '//sams:shape[1]//gml:name', xml_ns(xml)) %>%
          sapply(xml_text) %>%
          rep(times=length(tday))

  fmisid <- rep(fmisid, times=length(tday))

  data <- data.frame(fmisid, name, time, tday, tmin, tmax, rain, snow)

  return(data)

}
