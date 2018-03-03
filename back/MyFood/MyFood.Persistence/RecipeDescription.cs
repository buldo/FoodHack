using System;
using System.Collections.Generic;

namespace MyFood.Persistence
{
    public class RecipeDescription
    {
        public RecipeDescription(Guid id, string title, string previewUrl)
        {
            Id = id;
            Title = title;
            PreviewUrl = previewUrl;
        }

        public Guid Id { get; }
        public string Title { get; }
        public string PreviewUrl { get; }
    }
}