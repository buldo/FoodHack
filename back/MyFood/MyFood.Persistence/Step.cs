using System.Collections.Generic;

namespace MyFood.Persistence
{
    public class Step
    {
        public int Order { get; set; }
        public string Description { get; set; }
        public string VoiceDescription { get; set; }
        public string PictureUrl { get; set; }
        public int? TimeInSec { get; set; }
        public string PushText { get; set; }

        public List<string> Tips { get; set; }
    }
}