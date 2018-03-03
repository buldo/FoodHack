using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MyFood.Api.Data;
using MyFood.Persistence;

namespace MyFood.Api.Controllers
{
    [Produces("application/json")]
    [Route("api/Recipes")]
    public class RecipesController : Controller
    {
        private readonly IMapper _mapper;
        private readonly RecipesRepository _repo;

        public RecipesController(
            IMapper mapper,
            RecipesRepository repo)
        {
            _mapper = mapper;
            _repo = repo;
        }
        // GET: api/Recipes
        [HttpGet]
        public IEnumerable<RecipeDescriptionDto> Get()
        {
            return _mapper.Map<IEnumerable<RecipeDescriptionDto>>(_repo.GetDescriptions().ToList());
        }

        // GET: api/Recipes/5
        [HttpGet("{id}", Name = "Get")]
        public RecipeDto Get(Guid id)
        {
            return _mapper.Map<RecipeDto>(_repo.Get(id));
        }

        // POST: api/Recipes
        [HttpPost]
        public void Post([FromBody]RecipeDto value)
        {
            var recipe = _mapper.Map<Recipe>(value);
            recipe.Id = Guid.NewGuid();
            _repo.Insert(recipe);
        }

        // PUT: api/Recipes/5
        //[HttpPut("{id}")]
        //public void Put(int id, [FromBody]string value)
        //{
        //}

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public void Delete(Guid id)
        {
            _repo.Delete(id);
        }
    }
}
