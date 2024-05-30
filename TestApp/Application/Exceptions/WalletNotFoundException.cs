public class WalletNotFoundException : Exception
{
    public WalletNotFoundException() : base("Wallet is missing") { }
}
