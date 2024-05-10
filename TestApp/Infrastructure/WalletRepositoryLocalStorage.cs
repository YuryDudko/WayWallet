using Domain;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure;

public class WalletRepositoryLocalStorage: IWalletRepository
{
    private readonly AppDbContext _context;

    public WalletRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task UpdateWalletBalance(Wallet wallet, int newWalletBalance)
    {
        wallet.WalletBalance = newWalletBalance;
        await _context.SaveChangesAsync();
    }

    public async Task RenameWallet(Wallet wallet, string newWalletName)
    {
        wallet.WalletName = newWalletName;
        await _context.SaveChangesAsync();
    }

    public async Task<Wallet> GetWalletByName(string walletName)
    {
        return await _context.Wallets.FirstOrDefaultAsync(w => w.WalletName == walletName);
    }

    public async Task DeleteWalletAsync(Wallet wallet)
    {
        _context.Wallets.Remove(wallet);
        await _context.SaveChangesAsync();
    }

    public async Task AddWalletAsync(Wallet wallet)
    {
        _context.Wallets.Add(wallet);
        await _context.SaveChangesAsync();
    }
}
