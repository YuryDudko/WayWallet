

namespace Domain;

public class Wallet
{
    public double WalletBalance { get; set; }
    public string WalletName { get; set; }
    public User WalletUser { get; set; }
    public string KeyPhrase { get; set; }
}
