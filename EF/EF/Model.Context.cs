﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class AdventureworksDW2016CTP3Entities : DbContext
    {
        public AdventureworksDW2016CTP3Entities()
            : base("name=AdventureworksDW2016CTP3Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<DatabaseLog> DatabaseLogs { get; set; }
        public virtual DbSet<DimAccount> DimAccounts { get; set; }
        public virtual DbSet<DimCurrency> DimCurrencies { get; set; }
        public virtual DbSet<DimCustomer> DimCustomers { get; set; }
        public virtual DbSet<DimDate> DimDates { get; set; }
        public virtual DbSet<DimDepartmentGroup> DimDepartmentGroups { get; set; }
        public virtual DbSet<DimEmployee> DimEmployees { get; set; }
        public virtual DbSet<DimGeography> DimGeographies { get; set; }
        public virtual DbSet<DimOrganization> DimOrganizations { get; set; }
        public virtual DbSet<DimProduct> DimProducts { get; set; }
        public virtual DbSet<DimProductCategory> DimProductCategories { get; set; }
        public virtual DbSet<DimProductSubcategory> DimProductSubcategories { get; set; }
        public virtual DbSet<DimPromotion> DimPromotions { get; set; }
        public virtual DbSet<DimReseller> DimResellers { get; set; }
        public virtual DbSet<DimSalesReason> DimSalesReasons { get; set; }
        public virtual DbSet<DimSalesTerritory> DimSalesTerritories { get; set; }
        public virtual DbSet<DimScenario> DimScenarios { get; set; }
        public virtual DbSet<FactAdditionalInternationalProductDescription> FactAdditionalInternationalProductDescriptions { get; set; }
        public virtual DbSet<FactCallCenter> FactCallCenters { get; set; }
        public virtual DbSet<FactCurrencyRate> FactCurrencyRates { get; set; }
        public virtual DbSet<FactInternetSale> FactInternetSales { get; set; }
        public virtual DbSet<FactProductInventory> FactProductInventories { get; set; }
        public virtual DbSet<FactResellerSale> FactResellerSales { get; set; }
        public virtual DbSet<FactResellerSalesXL_CCI> FactResellerSalesXL_CCI { get; set; }
        public virtual DbSet<FactResellerSalesXL_PageCompressed> FactResellerSalesXL_PageCompressed { get; set; }
        public virtual DbSet<FactSalesQuota> FactSalesQuotas { get; set; }
        public virtual DbSet<FactSurveyResponse> FactSurveyResponses { get; set; }
        public virtual DbSet<ProspectiveBuyer> ProspectiveBuyers { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
        public virtual DbSet<FactFinance> FactFinances { get; set; }
        public virtual DbSet<իմ_սարքած_սյունը> իմ_սարքած_սյունը { get; set; }
        public virtual DbSet<vAssocSeqLineItem> vAssocSeqLineItems { get; set; }
        public virtual DbSet<vAssocSeqOrder> vAssocSeqOrders { get; set; }
        public virtual DbSet<vDMPrep> vDMPreps { get; set; }
        public virtual DbSet<vTargetMail> vTargetMails { get; set; }
        public virtual DbSet<vTimeSery> vTimeSeries { get; set; }
    }
}