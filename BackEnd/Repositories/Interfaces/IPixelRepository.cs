using System.Collections.Generic;
using BackEnd.Models;

namespace BackEnd.Repositories.Interfaces
{
    public interface IPixelRepository
    {
         IEnumerable<Pixel> GetAll();
         Pixel GetSingle(int id);
         int UpdateColor(int id, string color);
    }
}
