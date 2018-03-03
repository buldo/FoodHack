using System;
using System.Collections.Generic;
using MongoDB.Bson.Serialization.Attributes;

namespace MyFood.Persistence
{
    public class RecipeDescription
    {
        [BsonId]
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string PreviewUrl { get; set; }
        public string Complexity { get; set; }
        public string Duration { get; set; }
    }
}