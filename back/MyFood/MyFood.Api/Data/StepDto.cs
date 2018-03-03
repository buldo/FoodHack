using System.Collections;
using System.Collections.Generic;
using MyFood.Api.Data.StepFeatures;

namespace MyFood.Api.Data
{
    public class StepDto
    {
        public string Title { get; set; }
        public string TitleImage { get; set; }
        public IEnumerable<StepFeatureDto> Features { get; set; }
    }
}