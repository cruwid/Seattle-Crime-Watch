
namespace Hello911InfoViz.Models
{
    using System;
    using System.Collections.Generic;

    public partial class CrimeAggregate
    {
        public string EventDay { get; set; }
        public string EventTimeHour { get; set; }
        public int CrimeCount { get; set; }
    }
}
