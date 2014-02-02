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
    public class sunMovementDataController : ApiController
    {
        Hello911Entities context = new Hello911Entities();
        public IEnumerable<sunTimingAggregate> getSunMovementTime()
        {
            sunTimingAggregate[] sunTimings = context.Database.SqlQuery<sunTimingAggregate>("select * from sunMovementData").ToArray<sunTimingAggregate>();
            return sunTimings;
        }
    }
}
