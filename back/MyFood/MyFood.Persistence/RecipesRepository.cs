using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using MongoDB.Driver;

namespace MyFood.Persistence
{
    public class RecipesRepository
    {
        private readonly MongoClient _client;

        internal RecipesRepository(MongoClient client)
        {
            _client = client;
        }
        public Recipe Get(Guid id)
        {
            return Data.GetAll().First(d => d.Id == id);
        }

        public IEnumerable<RecipeDescription> GetDescriptions()
        {
            return Data.GetAll().Select(d => new RecipeDescription
            {
                Id = d.Id,
                Title = d.Title,
                PreviewUrl = d.PreviewUrl,
                Complexity = d.Complexity,
                Duration = d.Duration
            });
        }
    }
}