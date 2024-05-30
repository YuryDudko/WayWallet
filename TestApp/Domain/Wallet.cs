namespace Domain;

public class Wallet
{
    public int Id { get; set; }
    public double WalletBalance { get; set; }
    public string WalletName { get; set; }
    public int? UserId { get; set; }
    //public User? User { get; set; }
    public string KeyPhrase { get; set; }
    public List<CryptoCurrency> CryptoCurrencies { get; set; } = new();
}

public class WalletInfo
{
    public string WalletName { get; set; }
    public double WalletBalance { get; set; }
    public string KeyPhrase { get; set; }
}

