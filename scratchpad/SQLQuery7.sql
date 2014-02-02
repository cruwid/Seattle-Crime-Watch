select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) 
as EventTimeHour, EventDay from crimeEventLog 
where EventClearanceDate>='2013-02-01' and EventClearanceDate<='2013-02-28' and Suburb='University District'
group by CAST(DATEPART(hh, EventTime) as nvarchar), EventDay
select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) as EventTimeHour, EventDay from crimeEventLog where EventClearanceDate>='2013-02-01'