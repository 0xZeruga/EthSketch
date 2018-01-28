using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EthSketch
{
    public class Pixel
    {
        public uint Times_Purchased;
        public ConsoleColor color;
        public string hexColor;
        public uint xpos;
        public uint ypos;

        //Sets basecost to 0.0005 Ethereum and doubles the price every time the pixel has been purchased.
        public double Cost{
            get{
                return Math.Pow(0.0005, Times_Purchased + 1);
            }
        }

        public Pixel(int pX, int pY){
            Times_Purchased = 0;
            color = ConsoleColor.White;
            if (pX == pY){
                Console.WriteLine(pX);
            }
        }
    }
}
