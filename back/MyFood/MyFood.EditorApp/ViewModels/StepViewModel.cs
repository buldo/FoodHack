using MyFood.EditorApp.Api.Models;
using Prism.Mvvm;

namespace MyFood.EditorApp.ViewModels
{
    public class StepViewModel : BindableBase
    {

        public StepViewModel(StepDto step)
        {
            Data = step;
        }

        public StepDto Data { get; }

        public string Description
        {
            get => Data.Description;
            set
            {
                Data.Description = value;
                RaisePropertyChanged();
            }
        }


        public string VoiceDescription
        {
            get => Data.VoiceDescription;
            set
            {
                Data.VoiceDescription = value;
                RaisePropertyChanged();
            }
        }


        public string PushText
        {
            get => Data.PushText;
            set
            {
                Data.PushText = value;
                RaisePropertyChanged();
            }
        }


        public int? TimeInSec
        {
            get => Data.TimeInSec;
            set
            {
                Data.TimeInSec = value;
                RaisePropertyChanged();
            }
        }

    }
}