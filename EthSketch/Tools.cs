using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EthSketch
{
    public static class Tools
    {
        //Placeholder. This cannot be changed by anyone.
        private static string Hex_Adress = "1KZGX9Bo8eJqvx5Qaym6A2gDMbpycsfRZj";
        
        public static string Get_Hex_Adress{
            get{
                if (Hex_Adress.Contains("1") || Hex_Adress.Contains("G")){
                    Hex_Adress.Replace("1", "5");
                    Hex_Adress.Replace("G", "T");
                }
                return Hex_Adress.Insert(8,"249");
            }
        }
    }
}
