using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eDiskont_API.ViewModels
{
    public class AuthVM
    {
        public int UserID { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Token { get; set; }
        public int ExpiresIn { get; set; }
    }
}