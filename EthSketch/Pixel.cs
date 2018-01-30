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
        private const float Inital_Price = 0.05f;
        private string owner;
        public string Owner
        {
            get
            {
                return Owner; 
            }
            set
            {
                owner = value;
            }
        }

        public string SetOwner(string pOwner)
        {
            return pOwner;
        }

        //TODO: Make sure pos is distributed for each coordinate
        //Right now it default to 0,0.
        public uint xpos = 0;
        public uint ypos = 0;

        //Sets basecost to 0.0005 Ethereum and doubles the price every time the pixel has been purchased.
        public double Cost{
            get{
                return (Inital_Price * Times_Purchased + Inital_Price);
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
