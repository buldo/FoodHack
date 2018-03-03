using System;
using System.Collections.Generic;

namespace MyFood.Api.Data
{
    public class RecipeDto
    {
        public string Title { get; set; }
        public string PreviewUrl { get; set; }
        public string Description { get; set; }
        public string Complexity { get; set; }
        public string Duration { get; set; }
        
        public List<string> Ingredients { get; set; }
        public List<StepDto> Steps { get; set; }
        public List<string> Devices { get; set; }
    }
}