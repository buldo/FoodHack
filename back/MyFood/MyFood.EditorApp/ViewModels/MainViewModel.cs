using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Practices.ServiceLocation;
using Microsoft.Rest;
using MyFood.EditorApp.Api;
using MyFood.EditorApp.Api.Models;
using MyFood.EditorApp.Views;
using Prism.Mvvm;
using Prism.Windows.Mvvm;
using Prism.Windows.Navigation;

namespace MyFood.EditorApp.ViewModels
{
    internal class MainViewModel : ViewModelBase
    {
        private readonly INavigationService _navigationService;

        public MainViewModel(INavigationService navigationService)
            : base()
        {
            _navigationService = navigationService;
        }

        public override void OnNavigatedTo(NavigatedToEventArgs e, Dictionary<string, object> viewModelState)
        {
            base.OnNavigatedTo(e, viewModelState);
            var client = ServiceLocator.Current.GetInstance<IApiClient>();
            client.ApiRecipesGetWithHttpMessagesAsync().ContinueWith(task => Loaded(task.Result.Body)).GetAwaiter().GetResult();
        }

        private void Loaded(IList<RecipeDescriptionDto> rec)
        {
            foreach (var descriptionDto in rec)
            {
                Previews.Add(new PreviewViewModel(descriptionDto.Id, descriptionDto.Title, descriptionDto.PreviewUrl));
            }
        }

        public ObservableCollection<PreviewViewModel> Previews { get; } = new ObservableCollection<PreviewViewModel>();

        public void NavigateTo(Guid? recipeId)
        {
            if(recipeId.HasValue)
            {
                var client = ServiceLocator.Current.GetInstance<IApiClient>();
                var rec = client.ApiRecipesByIdGetWithHttpMessagesAsync(recipeId.Value).GetAwaiter().GetResult();
                _navigationService.Navigate("Edit", rec.Body);
            }
        }
    }
}
