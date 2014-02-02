select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) as EventTime1, EventDay from crimeEventLog 
where EventClearanceDate>='2013-02-01' and EventClearanceDate<='2014-02-02' 
group by CAST(DATEPART(hh, EventTime) as nvarchar), EventDay ;w