using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Description;
using eDiskont_API.Models;
using eDiskont_API.ViewModels;

namespace eDiskont_API.Controllers
{
    public class OrdersController : ApiController
    {
        private eDiskontEntities dm = new eDiskontEntities();

        [HttpGet]
        [Route("api/Orders/GetByUser/{userId?}")]
        public IHttpActionResult GetByType(string userId = "1")
        {
            int id = Convert.ToInt32(userId);
            List<OrdersGetVM> vm = new List<OrdersGetVM>();
            List<Orders> orders = dm.Orders.Where(x => x.UserID == id).OrderByDescending(x=>x.OrderDate).ToList();
            foreach (var item in orders)
            {
                OrdersGetVM orderVM = new OrdersGetVM();

                OrdersData orderData = dm.OrdersData.Where(x => x.OrderDataID == item.OrderDataID).FirstOrDefault();

                orderVM.OrderID = item.OrderID;
                orderVM.Date = Convert.ToDateTime(item.OrderDate).ToShortDateString() + Convert.ToDateTime(item.OrderDate).ToShortTimeString();
                orderVM.TotalPrice = item.TotalPrice;
                orderVM.OrderData = new OrderDataVM()
                {
                    City = orderData.City,
                    Company = orderData.Company,
                    DeliveryAddress = orderData.DeliveryAddress,
                    DeliveryMethod = dm.DeliveryMethods.Where(x=>x.DeliveryMethodID == orderData.DeliveryMethodID).FirstOrDefault().MethodName,
                    FullName = orderData.FullName
                };


                orderVM.Items = new List<ItemsVM>();
                foreach (var orderitem in dm.OrdersItems.Where(x => x.OrderID == item.OrderID))
                {
                    orderVM.Items.Add(new ItemsVM()
                    {
                        Name = dm.Items.Where(x => x.ItemID == orderitem.ItemID).FirstOrDefault().ItemName,
                        Price = dm.Items.Where(x => x.ItemID == orderitem.ItemID).FirstOrDefault().Price,
                        Amount = orderitem.Amount
                    });
                }

                vm.Add(orderVM);
            }
            

            return Ok(vm);
        }

        [HttpPost]
        [ResponseType(typeof(Object))]
        public IHttpActionResult PostOrders([FromBody]OrdersPostVM obj)
        {
            OrdersData ordersData = new OrdersData() {
                 City = obj.orderData.city,
                 Company = obj.orderData.company,
                 DeliveryAddress = obj.orderData.address,
                 DeliveryMethodID = Convert.ToInt32(obj.orderData.deliveryMethod),
                 FullName = obj.orderData.name
            };
            ordersData = dm.OrdersData.Add(ordersData);
            dm.SaveChanges();

            Orders order = new Orders()
            {
                OrderDate = obj.date,
                OrderDataID = ordersData.OrderDataID,
                TotalPrice = obj.price,
                UserID = Convert.ToInt32(obj.userId)
            };
            order = dm.Orders.Add(order);
            dm.SaveChanges();

            foreach (var item in obj.orderItems)
            {
                dm.OrdersItems.Add(new OrdersItems()
                {
                    OrderID = order.OrderID,
                    ItemID = Convert.ToInt32(item.itemId),
                    Amount = item.value
                });
            }
            dm.SaveChanges();

            return Ok(obj);
        }

    }
}
