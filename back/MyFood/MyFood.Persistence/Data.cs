using System;
using System.Collections.Generic;

namespace MyFood.Persistence
{
    internal static class Data
    {
        private static readonly Guid Demo1Id = Guid.Parse("9B1D56CF-17B1-4888-94E6-C4A6F3227CA1");

        public static IEnumerable<Recipe> GetAll()
        {
            return new List<Recipe>()
            {
                new Recipe(
                    Demo1Id,
                    "Омлет",
                    "",
                    new List<Step>
                    {

                    })
            };
        }
    }
}