
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EthSketch
{
    public class User
    {
        public Pixel chosenPixel;
        public ConsoleColor color;
        public Canvas canvas;
        public double balance; //This should be retrieved from wallet.
        public string My_Adress;
        public const double MIN_AMOUNT = 0.0005;

        public User(){
            //Once account is created
            GenerateAdress();
            //When user clicks a pixel
            SelectPixel(0, 0, canvas);   
        }

        public string GenerateAdress(){
            //TODO: Do some magic
            return My_Adress;
        }

        public void update(){

        }

        //Takes x, y mouse coordinates and translates from field to input params.
        //Assigns the pixel at current position.
        public static Pixel SelectPixel(int x, int y, Canvas pCanvas){
            foreach (Pixel p in pCanvas.Pixels){
                if (x == p.xpos && y == p.ypos){
                    return p;
                }
            }
            Console.WriteLine("Pixel not found");
            return null;
        }

        //Takes x, y mouse coordinates and translates from field to input params.
        //Assigns color to the pixel.
        public static string SelectHexParser(int x, int y, ConsoleColor pColor){
            if(x == null || y == null){
                return null;
            }
            else{
                //Probably not returned as a hex string.
                return pColor.ToString();
            }
            //TODO: Find a way to parse hexslider through x and y to recieve the hexstring.   
        }

        public static void Confirm(double balance, Pixel chosenPixel, string Hex, string _From){
            if(balance >= MIN_AMOUNT && chosenPixel != null && Hex != null){
                if(balance >= chosenPixel.Cost){
                    balance -= chosenPixel.Cost;
                    SendTransaction(_From, Tools.Get_Hex_Adress,chosenPixel.Cost);
                    Console.WriteLine(Tools.Get_Hex_Adress);
                    chosenPixel.hexColor = Hex;
                    chosenPixel.Times_Purchased += 1;
                }
            }
        }

        /// <summary>
        /// Value add to Ethereum Wallet. From, To, Value.
        /// </summary>
        public static void SendTransaction(string _From, string _To, double _value)
        {

        }


    }
}
