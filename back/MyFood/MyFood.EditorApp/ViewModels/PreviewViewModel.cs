using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Prism.Mvvm;

namespace MyFood.EditorApp.ViewModels
{
    internal class PreviewViewModel : BindableBase
    {
        public PreviewViewModel(string title, string previewUrl)
        {
            Title = title;
            PreviewUrl = previewUrl;
        }

        public string Title { get; }

        public string PreviewUrl { get; }
    }
}
