using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace EthSketch
{
    public class Canvas
    {
        public int Canvas_X;
        public int Canvas_Y;
        public Pixel pix;
        //TODO: Make this a dictionary or something.
        public List<Pixel> Pixels = new List<Pixel>();
        private int TestPixelCounter = 0;
        private bool Is_Expandable;

        public Canvas(){
            Canvas_X = 256;
            Canvas_Y = 256;
            Add_Initial_Pixels(Canvas_X, Canvas_Y);
        }

        public void Add_Initial_Pixels(int x, int y){
            Canvas_X = x;
            Canvas_Y = y;
            if (x != Canvas_X || y != Canvas_Y){
                Console.WriteLine("Input param error");
            }
            else{
                for (int i = 0; i < x; i++){
                    Console.WriteLine(i);
                    for (int j = 0; j < y; j++){
                        var p = new Pixel(i, j);
                        Pixels.Add(p);
                        TestPixelCounter += 1;
                        Console.WriteLine("TestPixelCounter: " + TestPixelCounter + " Xpos: " + i + " Ypox: " + j);
                    }
                }
            }              
        }

        public static bool CheckExpansion(Canvas _canvas, List<Pixel> _pixels){
            foreach (Pixel p in _pixels){
                if(p.Times_Purchased == 0){
                    Console.WriteLine(p.xpos + " " + p.ypos + "has not been purchased yet");
                    return false;
                }
            }
            return true;
        }

        public void Add_Expansion_Pixels(bool _IsExpandable, int x, int y){
            int Old_X = Canvas_X;
            int Old_Y = Canvas_Y;
            Canvas_X = Canvas_X * 2;
            Canvas_Y = Canvas_Y * 2;
            for (int i = Old_X; i < Canvas_X; i++){ 
                //Console.WriteLine(i);
                for (int j = Old_Y; j < Canvas_Y; j++){
                    var p = new Pixel(i, j);
                    Pixels.Add(p);
                    TestPixelCounter += 1;
                    Console.WriteLine("TestPixelCounter: " + TestPixelCounter + " Xpos: " + i + " Ypox: " + j); 
                }
            }
        }
    }
}
