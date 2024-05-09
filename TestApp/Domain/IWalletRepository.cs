

namespace Domain;

public interface IWalletRepository
{
    public Task UpdateWalletBalance(Wallet wallet , int NewWalletBalance);
    public Task RenameWallet(Wallet wallet , string NewWalletName);
    public Task DeleteWalletAsync(Wallet wallet);    
    public Task AddWalletAsync(Wallet wallet);

}
