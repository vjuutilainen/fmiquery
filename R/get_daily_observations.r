get_daily_observations = function(key,fmisid,year) {

	starttime = paste(year,'-01-01',sep='')
  endtime = paste(year,'-12-31',sep='')

  storedquery_id = 'fmi::observations::weather::daily::timevaluepair'
  parameters = 'tday,tmin,tmax,rrday,snow'

  url = paste('http://data.fmi.fi/fmi-apikey/',key,'/wfs?request=getFeature&storedquery_id=',storedquery_id,'&crs=EPSG::3067&fmisid=',fmisid,'&starttime=',starttime,'&endtime=',endtime,'&parameters=',parameters,sep='')

  xml = read_xml(url)

  # Check from time if there is data, otherwise return NULL
  time = xml_find_all(xml,'//wfs:member[1]//wml2:time', xml_ns(xml))

  if(length(time) == 0) {
    return(NULL)
  }

  time = sapply(time,xml_text)
  time = as.POSIXlt(time, format='%Y-%m-%d', tz='')
  
  tday = xml_find_all(xml,'//wfs:member[1]//wml2:value', xml_ns(xml))
  tday = sapply(tday,xml_text)
  tday = as.numeric(tday)
  
  tmin = xml_find_all(xml,'//wfs:member[2]//wml2:value', xml_ns(xml))
  tmin = sapply(tmin,xml_text)
  tmin = as.numeric(tmin)
  
  tmax = xml_find_all(xml,'//wfs:member[3]//wml2:value', xml_ns(xml))
  tmax = sapply(tmax,xml_text)
  tmax = as.numeric(tmax)

  rain = xml_find_all(xml,'//wfs:member[4]//wml2:value', xml_ns(xml))
  rain = sapply(rain,xml_text)
  rain = as.numeric(rain)
  
  snow = xml_find_all(xml,'//wfs:member[5]//wml2:value', xml_ns(xml))
  snow = sapply(snow,xml_text)
  snow = as.numeric(snow)
  
  name = xml_find_all(xml,'//sams:shape[1]//gml:name', xml_ns(xml))
  name = sapply(name,xml_text)
  name = rep(name, times=length(tday))

  # Repeat fmisid column using time values
  fmisid = rep(fmisid, times=length(tday))
  
  df = data.frame(fmisid,name,time,tday,tmin,tmax,rain,snow)

  return(df)

}