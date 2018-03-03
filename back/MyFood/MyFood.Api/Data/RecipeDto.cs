using System;
using System.Collections.Generic;

namespace MyFood.Api.Data
{
    public class RecipeDto
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string PreviewUrl { get; set; }
        public IEnumerable<StepDto> Steps { get; set; }
    }
}