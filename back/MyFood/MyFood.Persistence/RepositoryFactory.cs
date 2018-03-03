using System;
using System.Collections.Generic;
using System.Text;
using MongoDB.Driver;

namespace MyFood.Persistence
{
    public class RepositoryFactory
    {
        private readonly MongoClient _client;

        public RepositoryFactory(string connectionString)
        {
            //_client = new MongoClient(connectionString);
        }

        public RecipesRepository Create()
        {
            return new RecipesRepository(null);
            //return new RecipesRepository(_client);
        }
    }
}
