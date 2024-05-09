using Domain;

namespace Infrastructure;

public class WalletRepositoryLocalStorage: IWalletRepository
{
    private readonly List<Wallet> _wallets = new List<Wallet>();

    public Task UpdateWalletBalance(Wallet wallet , int NewWalletBalance)
    {
        wallet.WalletBalance = NewWalletBalance;
        return Task.CompletedTask;
    }
    public Task RenameWallet(Wallet wallet , string NewWalletName)
    {
        wallet.WalletName = NewWalletName;
        return Task.CompletedTask;
    }
    public Wallet GetWalletByName(string walletname)
    {
        return _wallets.FirstOrDefault(u => u.WalletName == walletname);
    }
    public Task DeleteWalletAsync(Wallet wallet)
    {
        _wallets.Remove(wallet);
        return Task.CompletedTask;
    }
    public Task AddWalletAsync(Wallet wallet)
    {
        _wallets.Add(wallet);
        return Task.CompletedTask;
    }
}
