

namespace Domain;

public class Purchase
{
    public int Id { get; set; }
    public string Name { get; set; }
    public double PurchaseRateValue { get; set; }
    public double OrderAmount { get; set; } //coins number wanted to buy
    public DateTime OrderDate { get; set; }
    public String ReceiverAdress { get; set; }
    public double PurchaseAmount { get; set; } //money in usdt be send to user
    public String CryptoAbbreviation { get; set; }
    public int? FinanceSystemId { get; set; }
    public FinanceSystem? FinanceSystem { get; set; }

}
