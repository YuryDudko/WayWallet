

namespace Domain;

public class Sale
{
    public int Id { get; set; }
    public string Name { get; set; }
    public double SaleRateValue { get; set; }
    public double OrderAmount { get; set; } //coins number wanted to sell
    public DateTime OrderDate { get; set; }
    public String SenderAdress { get; set; }
    public double SaleAmount { get; set; } //money in usdt be send to user
    public String CryptoAbbreviation { get; set; }
    public int? FinanceSystemId { get; set; }
    public FinanceSystem? FinanceSystem { get; set; }
}
