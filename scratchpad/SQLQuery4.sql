select COUNT(*) as crimeCount, DATEPART(hh, EventTime) EventTime, EventDay from crimeEventLog 
where EventClearanceDate>='2012-01-01' and EventClearanceDate<='2013-02-02'  and EventClearanceSubGroup = 'THEFTS'
group by DATEPART(hh, EventTime), EventDay
order by EventDay, DATEPART(hh, EventTime) EventTime

--select DATEPART(hh, EventTime) from crimeEventLog