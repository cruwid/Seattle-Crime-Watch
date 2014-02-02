using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Hello911InfoViz.Models
{
    public class monthCrimeAggregate
    {
        public int month { get; set; }
        public string monthName { get; set; }
        public int days { get; set; }
        public int[] hourAggregate { get; set; }
    }

}