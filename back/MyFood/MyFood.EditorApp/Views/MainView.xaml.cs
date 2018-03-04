using System;
using Windows.UI.Xaml.Controls;
using MyFood.EditorApp.ViewModels;

// The Blank Page item template is documented at https://go.microsoft.com/fwlink/?LinkId=402352&clcid=0x409

namespace MyFood.EditorApp.Views
{
    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class MainView : Page
    {
        public MainView()
        {
            this.InitializeComponent();
        }

        private void ListViewBase_OnItemClick(object sender, ItemClickEventArgs e)
        {
            ((MainViewModel) DataContext).NavigateTo(((PreviewViewModel)e.ClickedItem).Id);
        }
    }
}
