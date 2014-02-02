/*Crime plot datastructure*/
select EventClearanceSubGroup as crimeType,CAST(EventClearanceDate as nvarchar(10)) as crimeDate,CAST(EventTime as nvarchar(5)) as crimeTime from crimeEventLog
where YEAR(EventClearanceDate) = '2012' and EventClearanceSubGroup in ('ASSAULTS','RESIDENTIAL BURGLARIES','THEFTS','LIQUOR VIOLATIONS','GUN CALLS','NARCOTICS COMPLAINTS','HOMICIDE','ROBBERY','WEAPONS CALLS') and Suburb = 'University District'

select EventClearanceSubGroup as crimeType,CAST(EventClearanceDate as nvarchar(10)) as crimeDate,CAST(EventTime as nvarchar(5)) as crimeTime from crimeEventLog where YEAR(EventClearanceDate) = '2012' and EventClearanceSubGroup in(ASSAULTS) and Suburb= 'University District'

CREATE CLUSTERED INDEX CRIME_Date_Group_ID ON crimeEventLog(ID,EventClearanceDate,EventClearanceSubGroup);

/*Month Crime Data structure*/
select DATEPART (mm,EventClearanceDate) as month, cast(convert(char(3), EventClearanceDate, 0)as nvarchar(3)) as monthName, datepart(dd,dateadd(dd,-1,dateadd(mm,1,cast(cast(year(EventClearanceDate) as varchar)+'-'+cast(month(EventClearanceDate) as varchar)+'-01' as datetime)))) as days from crimeEventLog where YEAR(EventClearanceDate) = '2012' and EventClearanceSubGroup in ('ASSAULTS','RESIDENTIAL BURGLARIES','THEFTS','LIQUOR VIOLATIONS','GUN CALLS','NARCOTICS COMPLAINTS','HOMICIDE','ROBBERY','WEAPONS CALLS')group by DATEPART (mm,EventClearanceDate),convert(char(3), EventClearanceDate, 0),datepart(dd,dateadd(dd,-1,dateadd(mm,1,cast(cast(year(EventClearanceDate) as varchar)+'-'+cast(month(EventClearanceDate) as varchar)+'-01' as datetime)))) order by DATEPART (mm,EventClearanceDate)


select count(*) as crime , DATEPART(hh, EventTime) as timeSpan,MONTH(EventClearanceDate) as month from crimeEventLog where  YEAR(EventClearanceDate) = '2012' and EventClearanceSubGroup in ('ASSAULTS','RESIDENTIAL BURGLARIES','THEFTS','LIQUOR VIOLATIONS','GUN CALLS','NARCOTICS COMPLAINTS','HOMICIDE','ROBBERY','WEAPONS CALLS')
group by DATEPART(hh, EventTime) ,MONTH(EventClearanceDate)
order by MONTH(EventClearanceDate)

select  year(EventClearanceDate) from crimeEventLog group by year(EventClearanceDate)

select datepart(dd,dateadd(dd,-1,dateadd(mm,1,cast(cast(year(getdate()) as varchar)+'-'+cast(month(getdate()) as varchar)+'-01' as datetime))))

/*Hour Crime Data structure*/
select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) as timeSpan from crimeEventLog 
where YEAR(EventClearanceDate) = '2012'
group by CAST(DATEPART(hh, EventTime) as nvarchar)

