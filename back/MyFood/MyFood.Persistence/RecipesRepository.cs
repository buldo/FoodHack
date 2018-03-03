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
            var collection = GetMongoCollection();
            return collection.Find(d => d.Id == id).First();
        }

        public IEnumerable<RecipeDescription> GetDescriptions()
        {
            var collection = GetMongoCollection();
            return collection.AsQueryable().Select(d => new RecipeDescription
            {
                Id = d.Id,
                Title = d.Title,
                PreviewUrl = d.PreviewUrl,
                Complexity = d.Complexity,
                Duration = d.Duration
            });
        }

        public void Insert(Recipe recipe)
        {
            var collection = GetMongoCollection();
            collection.InsertOne(recipe);
        }

        public void Delete(Guid id)
        {
            var collection = GetMongoCollection();
            collection.DeleteOne(r => r.Id == id);
        }

        private IMongoCollection<Recipe> GetMongoCollection()
        {
            var database = _client.GetDatabase("MyFood");
            var collection = database.GetCollection<Recipe>("Recipies");
            return collection;
        }
    }
}