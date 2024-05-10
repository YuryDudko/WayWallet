
namespace Domain;

public class CryptoCurrency
{
    public int Id { get; set; }
    public string CurrencyCode { get; set;}
    public string CurrencyName { get; set;}
    public string CurrencyAdress { get; set;} //unique adress for transactions betw wallets
    public double CurrencyAmount { get; set;}
    public int? WalletId { get; set;}
    //public Wallet? Wallet { get; set;}
    public int? RateId { get; set;}
    public Rate? Rate { get; set;}
}
