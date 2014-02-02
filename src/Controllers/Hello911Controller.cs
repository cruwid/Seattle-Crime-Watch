using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using System.Web.Mvc;
using Hello911InfoViz.Models;
using System.Data.SqlClient;
using System.Text;

namespace Hello911InfoViz.Controllers
{
    public class Hello911Controller : ApiController
    {
        Hello911Entities context = new Hello911Entities();

        public IEnumerable<CrimeAggregate> getCrimeByDuration(String beginDate, String endDate, String Suburb,String crimeType)
        {
            StringBuilder queryString= new StringBuilder();
            queryString.Append("select COUNT(*) as crimeCount, CAST(DATEPART(hh, EventTime) as nvarchar) as EventTimeHour, EventDay from crimeEventLog where EventClearanceDate>=");
            if (beginDate != null)
            {
                queryString.Append("'"+beginDate+"'");
            }
            if (endDate != null)
            {
                queryString.Append(" and EventClearanceDate<='" + endDate + "'");
            }
            if (Suburb != null)
            {
                queryString.Append(" and Suburb='" + Suburb + "'");
            }
             if (crimeType == "ALL")
            {
                queryString.Append(" and EventClearanceSubGroup in ('ASSAULTS','RESIDENTIAL BURGLARIES','THEFTS','LIQUOR VIOLATIONS','GUN CALLS','NARCOTICS COMPLAINTS','HOMICIDE','ROBBERY','WEAPONS CALLS','AUTO THEFTS','COMMERCIAL BURGLARIES')");
            }
            else
            {
                queryString.Append(" and EventClearanceSubGroup in ('" + crimeType + "')");
            }
            queryString.Append(" group by CAST(DATEPART(hh, EventTime) as nvarchar), EventDay");
            CrimeAggregate[] crimes = context.Database.SqlQuery<CrimeAggregate>(queryString.ToString()).ToArray<CrimeAggregate>();
            return crimes;    
        }
    }
}
