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
    public class crimePlotController : ApiController
    {
        Hello911Entities context = new Hello911Entities();
        public IEnumerable<crimePlotAggregate> getCrimePlotValue(string year,string crimeType,string suburb)
        {
            StringBuilder queryString = new StringBuilder();
            queryString.Append("select EventClearanceSubGroup as crimeType,CAST(EventClearanceDate as nvarchar(10)) as crimeDate,CAST(EventTime as nvarchar(5)) as crimeTime from crimeEventLog where YEAR(EventClearanceDate) = @param1 and EventClearanceSubGroup in");
            if (crimeType == "ALL")
            {
                queryString.Append("('ASSAULTS','RESIDENTIAL BURGLARIES','THEFTS','LIQUOR VIOLATIONS','GUN CALLS','NARCOTICS COMPLAINTS','HOMICIDE','ROBBERY','WEAPONS CALLS','AUTO THEFTS','COMMERCIAL BURGLARIES')");
            }
            else
            {
                queryString.Append("('"+crimeType+"')");
            }
            if (suburb != "ALL")
            {
                queryString.Append(" and Suburb='" + suburb + "'");
            }

            crimePlotAggregate[] crimePlot = context.Database.SqlQuery<crimePlotAggregate>(queryString.ToString(), new SqlParameter("param1", year)).ToArray<crimePlotAggregate>();
            return crimePlot;
        }
    }
}
