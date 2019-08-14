using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

using eDiskont_API.Models;
using eDiskont_API.ViewModels;

namespace eDiskont_API.Controllers
{
    public class ItemsController : ApiController
    {
        private eDiskontEntities dm = new eDiskontEntities();

        [HttpGet]
        [Route("api/Items/GetImage/{imageName?}")]
        public HttpResponseMessage GetImage(string imageName = "")
        {
            var response = Request.CreateResponse(HttpStatusCode.OK);

            var path = "~/Images/" + imageName;
            path = System.Web.Hosting.HostingEnvironment.MapPath(path);
            var ext = System.IO.Path.GetExtension(path);

            var contents = System.IO.File.ReadAllBytes(path);

            System.IO.MemoryStream ms = new System.IO.MemoryStream(contents);

            response.Content = new StreamContent(ms);
            response.Content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("image/" + ext);

            return response;
        }

        [HttpGet]
        [Route("api/Items/GetByType/{typeId?}")]
        public IHttpActionResult GetByType(string typeId = "1")
        {
            int id = Convert.ToInt32(typeId);
            List<Items> items = dm.Items.Where(x => x.ItemTypeID == id).ToList();
         
           return Ok(items);
        }
    }
}
