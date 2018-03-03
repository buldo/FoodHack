using System;
using AutoMapper;
using MyFood.Api.Data;
using MyFood.Api.Data.StepFeatures;
using MyFood.Persistence;
using MyFood.Persistence.StepFeatures;

namespace MyFood.Api
{
    public class MappingProfile: Profile
    {
        public MappingProfile()
        {
            // Add as many of these lines as you need to map your objects
            CreateMap<Recipe, RecipeDto>();
            CreateMap<Step, StepDto>();
            CreateMap<StepFeature, StepFeatureDto>();
            CreateMap<RecipeDescription, RecipeDescriptionDto>();
        }
    }
}
