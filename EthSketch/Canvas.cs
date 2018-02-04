using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace EthSketch
{
    public class Canvas
    {
        public uint Canvas_X;
        public uint Canvas_Y;
        public Pixel pix;
        //TODO: Make this a dictionary or something.
        public List<Pixel> Pixels = new List<Pixel>();
        private int TestPixelCounter = 0;
        public bool Is_Expandable;
        public uint[,] PixelGrid;
        
        public Canvas(){
            Canvas_X = 256;
            Canvas_Y = 256;
            //Add_Initial_Pixels(Canvas_X, Canvas_Y);

            PrintPixels();
        }
        
        //Print pixel locations
        public void PrintPixels()
        {
            Console.WriteLine(CheckExpansion(this, Pixels, Is_Expandable));
            foreach (Pixel p in Pixels)
            {
                Console.WriteLine(p.Times_Purchased.ToString());
               //Console.WriteLine(p.xpos + "," + p.ypos);
                //p.Times_Purchased += 1;
            }
            //Console.WriteLine(CheckExpansion(this, Pixels, Is_Expandable));
        }

        public void Add_Initial_Pixels(uint x, uint y){
            Canvas_X = x;
            Canvas_Y = y;
            if (x != Canvas_X || y != Canvas_Y){
                Console.WriteLine("Input param error");
            }
            else{
                for (uint i = 0; i < x; i++){
                    for (uint j = 0; j < y; j++){
                        var p = new Pixel(i, j);
                        Pixels.Add(p);
                        TestPixelCounter += 1;
                        //Console.WriteLine("TestPixelCounter: " + TestPixelCounter + " Xpos: " + i + " Ypox: " + j);
                    }
                }
            }              
        }

        public static bool CheckExpansion(Canvas _canvas, List<Pixel> _pixels, bool IsExpandable){
            if(IsExpandable)
            foreach (Pixel p in _pixels){
                    Console.WriteLine(p.Times_Purchased);

                    if (p.Times_Purchased == 0){
                    Console.WriteLine(p.xpos + " " + p.ypos + "has not been purchased yet");
                        
                    return false;
                }
            }
            else { Console.WriteLine("All pixels has been purchased"); }
            return true;
        }

        public void Add_Expansion_Pixels(bool _IsExpandable, uint x, uint y){
            uint Old_X = Canvas_X;
            uint Old_Y = Canvas_Y;
            Canvas_X = Canvas_X * 2;
            Canvas_Y = Canvas_Y * 2;
            for (uint i = Old_X; i < Canvas_X; i++){ 
                //Console.WriteLine(i);
                for (uint j = Old_Y; j < Canvas_Y; j++){
                    var p = new Pixel(i, j);
                    Pixels.Add(p);
                    TestPixelCounter += 1;
                    Console.WriteLine("TestPixelCounter: " + TestPixelCounter + " Xpos: " + i + " Ypox: " + j); 
                }
            }
        }
    }
}
