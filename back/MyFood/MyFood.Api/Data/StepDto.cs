using System.Collections.Generic;
namespace MyFood.Api.Data
{
    public class StepDto
    {
        public string Description { get; set; }
        public string VoiceDescription { get; set; }
        public string PictureUrl { get; set; }
        public int? TimeInSec { get; set; }
        public string PushText { get; set; }

        public List<string> Tips { get; set; }
    }
}