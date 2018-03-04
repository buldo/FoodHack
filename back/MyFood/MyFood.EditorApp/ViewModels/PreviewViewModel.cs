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
        public PreviewViewModel(Guid? id, string title, string previewUrl)
        {
            Id = id;
            Title = title;
            PreviewUrl = previewUrl;
        }

        public Guid? Id { get; }

        public string Title { get; }

        public string PreviewUrl { get; }
    }
}
