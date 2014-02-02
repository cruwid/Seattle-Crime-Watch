DROP table crimeEventLog

CREATE TABLE [dbo].[crimeEventLog] (
    [ID]                     INT           NOT NULL,
    [EventNumber]            BIGINT        NOT NULL,
    [GeneralOffenseNumber]   BIGINT        NOT NULL,
    [EventClearanceCode]     INT           NOT NULL,
    [EventClearanceSubGroup] VARCHAR (100) NOT NULL,
    [EventClearanceGroup]    VARCHAR (100) NOT NULL,
    [EventClearanceDate]     DATE          NULL,
    [EventTime]              TIME (7)      NULL,
    [Longitude]              VARCHAR (50)  NULL,
    [Suburb]                 VARCHAR (50)  NULL,
    [Street]                 VARCHAR (100) NULL,
    [Zipcode]                VARCHAR (50)  NULL,
    [Latitude]               VARCHAR (50)  NULL,
    [IncidentLocation]       VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

BULK INSERT crimeEventLog
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\Refined Data\Partial-Seattle-Police-Dept-911-Incident-csv.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
BULK INSERT crimeEventLog
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\Refined Data\Split Data\Refined Split Data\Seattle_Police_911Incident_2013-csv.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
BULK INSERT crimeEventLog
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\Refined Data\Split Data\Refined Split DatA\Seattle_Police_911Incident_2012_Nov_Dec-csv.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
BULK INSERT crimeEventLog
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\Refined Data\Split Data\Refined Split Data\Seattle_Police_911Incident_2012_Jan_Feb-csv.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
BULK INSERT crimeEventLog
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\Refined Data\Split Data\Refined Split Data\Seattle_Police_911Incident_2012_Sept_Oct-csv.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
BULK INSERT crimeEventLog
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\Refined Data\Split Data\Refined Split Data\Seattle_Police_911Incident_2012_Jul_Aug-csv.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
BULK INSERT crimeEventLog
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\Refined Data\Split Data\Refined Split Data\Seattle_Police_911Incident_2012_Mar_Apr-csv.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
BULK INSERT crimeEventLog
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\Refined Data\Split Data\Refined Split Data\Seattle_Police_911Incident_2012_May_Jun-csv.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)


ALTER TABLE crimeEventLog
ADD EventDay varchar(50) NULL

update crimeEventLog set EventDay = DATENAME(dw,EventClearanceDate)



TRUNCATE TABLE crimeEventLog

select * from crimeEventLog
Where Zipcode='98105' and EventClearanceDate> '2/10/2013' and EventClearanceDate<GETDATE()



/* sunmovement */
CREATE TABLE [dbo].[sunMovementData]
(
	[date] DATE NOT NULL PRIMARY KEY, 
    [bTwilight] TIME(0) NULL, 
    [sunrise] TIME(0) NULL, 
    [sunTransit] TIME(0) NULL, 
    [sunset] TIME(0) NULL, 
    [eTwilight] TIME(0) NULL
)

BULK INSERT sunMovementData
FROM 'D:\MSIM-UW12-14\Year 1\Quarter II\INFO VISUALIZATION\Project\daynight data.csv'
WITH
(
  FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

select * from sunMovementData

select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) as EventTime1, EventDay from crimeEventLog 
where EventClearanceDate>='2013-02-01' and EventClearanceDate<='2014-02-02' 
group by CAST(DATEPART(hh, EventTime) as nvarchar), EventDay ;w

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

select COUNT(*) as crimeCount, DATEPART(hh, EventTime) EventTime, EventDay from crimeEventLog 
where EventClearanceDate>='2012-01-01' and EventClearanceDate<='2013-02-02'  and EventClearanceSubGroup = 'THEFTS'
group by DATEPART(hh, EventTime), EventDay
order by EventDay, DATEPART(hh, EventTime) EventTime

--select DATEPART(hh, EventTime) from crimeEventLog

select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) 
as EventTimeHour, EventDay from crimeEventLog 
where EventClearanceDate>='2013-02-01' and EventClearanceDate<='2013-02-28' and Suburb='University District'
group by CAST(DATEPART(hh, EventTime) as nvarchar), EventDay
select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) as EventTimeHour, EventDay from crimeEventLog where EventClearanceDate>='2013-02-01'

select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) as EventTime1, EventDay from crimeEventLog 
where EventClearanceDate>='2013-02-01' and EventClearanceDate<='2014-02-02' 
group by CAST(DATEPART(hh, EventTime) as nvarchar), EventDay



