using AutoMapper;
using MyFood.Api.Data;
using MyFood.Persistence;

namespace MyFood.Api
{
    public class MappingProfile: Profile
    {
        public MappingProfile()
        {
            // Add as many of these lines as you need to map your objects
            CreateMap<Recipe, RecipeDto>();
            CreateMap<Step, StepDto>();
            CreateMap<RecipeDescription, RecipeDescriptionDto>().ForMember(dto => dto.Id, expression => expression.MapFrom(d => d.Id));

            CreateMap<RecipeDto, Recipe>();
            CreateMap<StepDto, Step>();
            CreateMap<RecipeDescriptionDto, RecipeDescription>();
        }
    }
}
