using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eDiskont_API.ViewModels
{
    public class OrdersGetVM
    {
        public int OrderID { get; set; }

        public List<ItemsVM> Items { get; set; }
        public OrderDataVM OrderData { get; set; }
        public string Date { get; set; }
        public decimal TotalPrice { get; set; }
    }

    public class ItemsVM
    {
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int Amount { get; set; }
    }

    public class OrderDataVM
    {
        public string FullName { get; set; }
        public string Company { get; set; }
        public string DeliveryMethod { get; set; }
        public string DeliveryAddress { get; set; }
        public string City { get; set; }
    }
}