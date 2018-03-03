namespace MyFood.Api.Data.StepFeatures
{
    public class TimerFeatureDto : StepFeatureDto
    {
        public override FeatureType Type => FeatureType.Timer;

        public int TimerSec { get; set; }

        public int TimeProlongationSec { get; set; }

        public int MaxTimerTimeSec { get; set; }
    }
}