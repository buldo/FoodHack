using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using MyFood.EditorApp.Api.Models;
using Prism.Commands;
using Prism.Windows.Mvvm;
using Prism.Windows.Navigation;

namespace MyFood.EditorApp.ViewModels
{
    internal class EditorViewModel : ViewModelBase
    {
        private StepViewModel _selectedStep;
        private RecipeDto _data;

        public EditorViewModel()
        {
            AddStepCommand = new DelegateCommand(ExecuteAdd);
        }

        private void ExecuteAdd()
        {
            var stepDto = new StepDto(){Description = "Новый шаг"};
            _data.Steps.Add(stepDto);
            var stepViewModel = new StepViewModel(stepDto);
            Steps.Add(stepViewModel);
            SelectedStep = stepViewModel;
        }

        public override void OnNavigatedTo(NavigatedToEventArgs e, Dictionary<string, object> viewModelState)
        {
            base.OnNavigatedTo(e, viewModelState);
            _data = (RecipeDto)e.Parameter;
            RaisePropertyChanged(nameof(Title));
            RaisePropertyChanged(nameof(Description));
            foreach (var step in _data.Steps)
            {
                Steps.Add(new StepViewModel(step));
            }
        }

        public string Title
        {
            get => _data.Title;
            set
            {
                _data.Title = value;
                RaisePropertyChanged();
            }
        }

        public string Description
        {
            get => _data.Description;
            set
            {
                _data.Description = value;
                RaisePropertyChanged();
            }
        }

        public ObservableCollection<StepViewModel> Steps { get; } = new ObservableCollection<StepViewModel>();

        public StepViewModel SelectedStep
        {
            get => _selectedStep;
            set => SetProperty(ref _selectedStep, value);
        }

        public ICommand AddStepCommand { get; }
    }
}
