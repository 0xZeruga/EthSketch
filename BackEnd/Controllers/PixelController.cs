using System;
using System.Linq;
using BackEnd.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace BackEnd.Controllers
{
    [Route("api/pixels")]
    public class PixelController : Controller
    {
        private IPixelRepository _pixelRepository;
    
        public PixelController(IPixelRepository pixelRepository)
        {
            _pixelRepository = pixelRepository ?? throw new ArgumentException(nameof(pixelRepository));
        }

        [HttpPost("get/all")]
        public IActionResult GetAllPixels()
        {
            var pixels = _pixelRepository.GetAll();

            if (pixels == null || !pixels.Any())
            {
                return new NotFoundResult();
            }

            return new OkObjectResult(pixels);
        }

        [HttpPost("get/{id}")]
        public IActionResult GetPixel(int id)
        {
            var pixel = _pixelRepository.GetSingle(id);

            if (pixel == null)
            {
                return NotFound();
            }

            return new OkObjectResult(pixel);
        }

        [HttpPost("update/{id}/{color}")]
        public IActionResult UpdatePixel(int id, string color)
        {
            var result = _pixelRepository.UpdateColor(id, color);

            if (result != 1)
            {
                return NotFound();
            }

            return Ok();
        }
    }
}