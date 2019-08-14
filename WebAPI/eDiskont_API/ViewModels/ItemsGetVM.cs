using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eDiskont_API.ViewModels
{
    public class ItemsGetVM
    {
        public int ItemID { get; set; }
        public string ItemName { get; set; }
        public int PackSize { get; set; }
        public decimal Price { get; set; }
    }
}