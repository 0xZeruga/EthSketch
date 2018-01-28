using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EthSketch
{
    class Program
    {
        static void Main(string[] args)
        {
            Canvas a = new Canvas();
            a.Add_Initial_Pixels(256,256);
            a.Add_Expansion_Pixels(true,a.Canvas_X,a.Canvas_Y);

            //User.Confirm(10,new Pixel(10,10), "hej", "hej");
            Console.ReadLine();
        }
    }
}
