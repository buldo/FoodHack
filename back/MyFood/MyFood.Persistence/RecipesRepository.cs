using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace MyFood.Persistence
{
    public class RecipesRepository
    {
        public IEnumerable<Recipe> Get()
        {
            return Data.GetAll();
        }

        public Recipe Get(Guid id)
        {
            return Data.GetAll().First(d => d.Id == id);
        }

        public IEnumerable<(Guid Id, string Title, string PreviewUrl)> GetDescriptions()
        {
            return Data.GetAll().Select(d => (d.Id, d.Name, d.PreviewUrl));
        }
    }
}