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
            Console.WriteLine(a.Is_Expandable);
            a.Add_Initial_Pixels(256,256);
            //a.Add_Expansion_Pixels(true,a.Canvas_X,a.Canvas_Y);
            
            User u = new User();
            u.Adress = "SD2h2h92h59X99219u2";
            u.balance = 100;
            Pixel temp = User.SelectPixel(0, 0, a);
            User.SelectHexParser(temp,ConsoleColor.Red);
            //User.Confirm(u.balance, temp, Tools.Get_Hex_Adress, u.Adress);
            //User.Confirm(u.balance, temp, Tools.Get_Hex_Adress, u.Adress);
            //User.Confirm(u.balance, temp, Tools.Get_Hex_Adress, u.Adress);
            //User.Confirm(10,new Pixel(10,10), "hej", "hej");
            Console.ReadLine();
        }
    }
}
