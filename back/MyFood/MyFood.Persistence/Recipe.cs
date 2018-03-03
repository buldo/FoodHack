using System;
using System.Collections.Generic;
using MongoDB.Bson.Serialization.Attributes;

namespace MyFood.Persistence
{
    public class Recipe
    {
        [BsonId]
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string PreviewUrl { get; set; }
        public string Description { get; set; }
        public string Complexity { get; set; }
        public string Duration { get; set; }
        
        public List<string> Ingredients { get; set; }
        public List<Step> Steps { get; set; }
        public List<string> Devices { get; set; }
    }
}
