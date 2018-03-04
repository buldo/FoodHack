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
using Prism.Mvvm;
using Prism.Windows.Mvvm;
using Prism.Windows.Navigation;

namespace MyFood.EditorApp.ViewModels
{
    internal class MainViewModel : ViewModelBase
    {
        public override void OnNavigatedTo(NavigatedToEventArgs e, Dictionary<string, object> viewModelState)
        {
            base.OnNavigatedTo(e, viewModelState);
            var client = ServiceLocator.Current.GetInstance<IApiClient>();
            client.ApiRecipesGetWithHttpMessagesAsync().ContinueWith(task => Loaded(task.Result.Body)).GetAwaiter().GetResult();
        }

        private void ContinuationAction(Task<HttpOperationResponse<IList<RecipeDescriptionDto>>> task, object o)
        {
            throw new NotImplementedException();
        }

        private void Loaded(IList<RecipeDescriptionDto> rec)
        {
            foreach (var descriptionDto in rec)
            {
                Previews.Add(new PreviewViewModel(descriptionDto.Title, descriptionDto.PreviewUrl));
            }
        }

        public ObservableCollection<PreviewViewModel> Previews { get; } = new ObservableCollection<PreviewViewModel>();
    }
}
