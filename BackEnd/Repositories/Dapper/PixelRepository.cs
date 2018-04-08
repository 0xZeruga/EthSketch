using System;
using System.Collections.Generic;
using BackEnd.Models;
using BackEnd.Repositories.Interfaces;

namespace BackEnd.Repositories.Dapper
{
    public class PixelRepository : IPixelRepository
    {
        public int UpdateColor(int id, string color)
        {
            return 0;
        }

        public IEnumerable<Pixel> GetAll()
        {
            return new List<Pixel>();
        }

        public Pixel GetSingle(int id)
        {
            return new Pixel();
        }
    }
}
