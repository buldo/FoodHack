using System;
using System.Collections.Generic;

namespace MyFood.Persistence
{
    public class Recipe
    {
        public Recipe(Guid id, string name, string previewUrl, List<Step> steps)
        {
            Id = id;
            Name = name;
            PreviewUrl = previewUrl;
            Steps = steps;
        }

        public Guid Id { get; }
        public string Name { get; }
        public string PreviewUrl { get; }
        public List<Step> Steps { get; }
    }
}
