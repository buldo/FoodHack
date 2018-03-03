using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace MyFood.Persistence
{
    public class RecipesRepository
    {
        public Recipe Get(Guid id)
        {
            return Data.GetAll().First(d => d.Id == id);
        }

        public IEnumerable<RecipeDescription> GetDescriptions()
        {
            return Data.GetAll().Select(d => new RecipeDescription(d.Id, d.Name, d.PreviewUrl));
        }
    }
}