using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eDiskont_API.ViewModels
{
    public class OrdersPostVM
    {
        public DateTime date { get; set; }
        public OrderData orderData { get; set; }
        public List<OrderItems> orderItems { get; set; }
        public decimal price { get; set; }
        public string userId { get; set; }


        public class OrderItems
        {
            public string itemId { get; set; }
            public int value { get; set; }
            public string itemName { get; set; }
            public decimal price { get; set; }
        }

        public class OrderData
        {
            public string address { get; set; }
            public string city { get; set; }
            public string company { get; set; }
            public string deliveryMethod { get; set; }
            public string name { get; set; }
        }
    }
}