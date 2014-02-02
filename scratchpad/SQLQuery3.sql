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

select * from crimeEventLog

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





TRUNCATE TABLE crimeEventLog

select * from crimeEventLog
Where Zipcode='98105' and EventClearanceDate> '2/10/2013' and EventClearanceDate<GETDATE()

ALTER TABLE crimeEventLog
ADD EventDay varchar(50) NULL