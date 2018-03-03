using System;
using System.Collections.Generic;
using System.Text;
using MyFood.Persistence.StepFeatures;

namespace MyFood.Persistence
{
    public class Step
    {
        public int Order { get; }
        public IEnumerable<StepFeature> Features { get; }
    }
}
