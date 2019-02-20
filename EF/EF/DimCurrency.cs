//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EF
{
    using System;
    using System.Collections.Generic;
    
    public partial class DimCurrency
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DimCurrency()
        {
            this.DimOrganizations = new HashSet<DimOrganization>();
            this.FactCurrencyRates = new HashSet<FactCurrencyRate>();
            this.FactInternetSales = new HashSet<FactInternetSale>();
            this.FactResellerSales = new HashSet<FactResellerSale>();
            this.FactResellerSalesXL_CCI = new HashSet<FactResellerSalesXL_CCI>();
            this.FactResellerSalesXL_PageCompressed = new HashSet<FactResellerSalesXL_PageCompressed>();
        }
    
        public int CurrencyKey { get; set; }
        public string CurrencyAlternateKey { get; set; }
        public string CurrencyName { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DimOrganization> DimOrganizations { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FactCurrencyRate> FactCurrencyRates { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FactInternetSale> FactInternetSales { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FactResellerSale> FactResellerSales { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FactResellerSalesXL_CCI> FactResellerSalesXL_CCI { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FactResellerSalesXL_PageCompressed> FactResellerSalesXL_PageCompressed { get; set; }
    }
}
