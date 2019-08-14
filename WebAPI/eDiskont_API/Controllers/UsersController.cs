using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Description;
using eDiskont_API.Models;
using eDiskont_API.ViewModels;

namespace eDiskont_API.Controllers
{
    public class UsersController : ApiController
    {
        private eDiskontEntities dm = new eDiskontEntities();

        [HttpGet]
        [Route("api/Users/LoginCheck/{email?}/{password?}")]
        public IHttpActionResult LoginCheck(string email = "", string password = "")
        {
            string token = Guid.NewGuid().ToString();

            Users user = dm.Users.Where(x => x.Email == email && x.Pass == password).FirstOrDefault();

            if (user != null)
            {
                AuthVM auth = new AuthVM()
                {
                    UserID = user.UserID,
                    Email = user.Email,
                    //Password = user.Pass,
                    Token = token,
                    ExpiresIn = 3600
                };

                dm.AuthTokens.Add(new AuthTokens
                {
                    Token = auth.Token,
                    UserID = auth.UserID,
                    IPAddress = "...",
                });

                dm.SaveChanges();

                return Ok(auth);
            }
            else
                return NotFound();
        }

        [HttpPost]
        public IHttpActionResult PostUsers([FromBody]RegisterVM obj)
        {
            if(obj == null)
            {
                return NotFound();
            }
            else
            {
                Users duplicate = dm.Users.FirstOrDefault(x => x.Email == obj.email);
                if(dm.Users.FirstOrDefault(x=>x.Email == obj.email) != null)
                {
                    return BadRequest();
                }
                else
                {
                    dm.Users.Add(new Users()
                    {
                        Email = obj.email,
                        Pass = obj.password
                    });
                    dm.SaveChanges();
                    return Ok();
                }
            }
        }

    }
}
