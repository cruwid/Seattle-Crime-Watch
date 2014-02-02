using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Hello911InfoViz.Models;
using System.Data.SqlClient;
using System.Text;

namespace Hello911InfoViz.Controllers
{
    public class monthPlotController : ApiController
    {
        Hello911Entities context = new Hello911Entities();
        public IEnumerable<monthCrimeAggregate> getmonthPlotValue(string year,string crimeType,string suburb)
        {

            monthCrimeAggregate[] monthPlot = null;
            StringBuilder queryString = new StringBuilder();
            StringBuilder queryString2 = new StringBuilder();
            queryString.Append("select DATEPART (mm,EventClearanceDate) as month, cast(convert(char(3), EventClearanceDate, 0)as nvarchar(3)) as monthName, datepart(dd,dateadd(dd,-1,dateadd(mm,1,cast(cast(year(EventClearanceDate) as varchar)+'-'+cast(month(EventClearanceDate) as varchar)+'-01' as datetime)))) as days from crimeEventLog where YEAR(EventClearanceDate) ='2012' and EventClearanceSubGroup in ");
            if (crimeType == "ALL")
            {
                queryString.Append("('ASSAULTS','RESIDENTIAL BURGLARIES','THEFTS','LIQUOR VIOLATIONS','GUN CALLS','NARCOTICS COMPLAINTS','HOMICIDE','ROBBERY','WEAPONS CALLS','AUTO THEFTS','COMMERCIAL BURGLARIES')");
            }
            else
            {
                queryString.Append("('" + crimeType + "')");
            }
            if (suburb != "ALL")
            {
                queryString.Append(" and Suburb='" + suburb + "'");
            }
             queryString.Append("group by DATEPART (mm,EventClearanceDate),convert(char(3), EventClearanceDate, 0),datepart(dd,dateadd(dd,-1,dateadd(mm,1,cast(cast(year(EventClearanceDate) as varchar)+'-'+cast(month(EventClearanceDate) as varchar)+'-01' as datetime)))) order by DATEPART (mm,EventClearanceDate)");

             TemMonthCrimeAggregate[] tempDate = context.Database.SqlQuery<TemMonthCrimeAggregate>(queryString.ToString()).ToArray<TemMonthCrimeAggregate>();

            queryString2.Append("select count(*) as crime , DATEPART(hh, EventTime) as timeSpan,MONTH(EventClearanceDate) as month from crimeEventLog where  YEAR(EventClearanceDate) = '2012' and EventClearanceSubGroup in ");
            if (crimeType == "ALL")
            {
                queryString2.Append("('ASSAULTS','RESIDENTIAL BURGLARIES','THEFTS','LIQUOR VIOLATIONS','GUN CALLS','NARCOTICS COMPLAINTS','HOMICIDE','ROBBERY','WEAPONS CALLS','AUTO THEFTS','COMMERCIAL BURGLARIES')");
            }
            else
            {
                queryString2.Append("('" + crimeType + "')");
            }
            if (suburb != "ALL")
            {
                queryString2.Append(" and Suburb='" + suburb + "'");
            }
            queryString2.Append("group by DATEPART(hh, EventTime) ,MONTH(EventClearanceDate)order by MONTH(EventClearanceDate)");

            TemCrimeAggregate[] timeCrime = context.Database.SqlQuery<TemCrimeAggregate>(queryString2.ToString()).ToArray<TemCrimeAggregate>();
            int k = 0;
            monthPlot = new monthCrimeAggregate[tempDate.Length];
            for (int i = 0; i < tempDate.Length; i++)
                {
                    monthPlot[i] = new monthCrimeAggregate();
                    monthPlot[i].days = tempDate[i].days;
                    monthPlot[i].month = tempDate[i].month;
                    monthPlot[i].monthName = tempDate[i].monthName;
                    monthPlot[i].hourAggregate = new int[24];
                    for (int j = 0; j < 24; j++)
                    {
                        if (k < timeCrime.Length)
                        {
                            if (timeCrime[k].month.Equals(i + 1))
                            {
                                if (timeCrime[k].timeSpan.Equals(j))
                                {
                                    monthPlot[i].hourAggregate[j] = timeCrime[k++].crime;
                                 }
                                else
                                {
                                    monthPlot[i].hourAggregate[j] = 0;
                                }
                            }
                        }
                    }
                }
           
            
            return monthPlot;
            
        }
    }
}