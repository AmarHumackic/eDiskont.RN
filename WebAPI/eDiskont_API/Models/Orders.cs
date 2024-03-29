//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace eDiskont_API.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Orders
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Orders()
        {
            this.OrdersItems = new HashSet<OrdersItems>();
        }
    
        public int OrderID { get; set; }
        public int OrderDataID { get; set; }
        public decimal TotalPrice { get; set; }
        public int UserID { get; set; }
        public Nullable<System.DateTime> OrderDate { get; set; }
    
        public virtual OrdersData OrdersData { get; set; }
        public virtual Users Users { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrdersItems> OrdersItems { get; set; }
    }
}
