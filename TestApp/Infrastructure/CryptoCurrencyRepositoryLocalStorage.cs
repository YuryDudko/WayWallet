
using Domain;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure;

public class CryptoCurrencyRepositoryLocalStorage: ICryptoCurrencyRepository
{
    private readonly AppDbContext _context;

    public CryptoCurrencyRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddCryptoCurrencyAsync(CryptoCurrency currency)
    {
       // _context.Wallets.Include(u => u.User).FirstOrDefault();
        _context.CryptoCurrencies.Add(currency);
        await _context.SaveChangesAsync();
    }

    public async Task<List<CryptoCurrency>> GetCryptocurrenciesByWalletId(int walletId)
    {
        return await _context.CryptoCurrencies.Where(cc => cc.WalletId == walletId).ToListAsync();
    }

    public async Task<CryptoCurrency> GetCryptoByAddress(string address)
    {
        return await _context.CryptoCurrencies.FirstOrDefaultAsync(c => c.CurrencyAdress == address);
    }
    public async Task<CryptoCurrency> GetCryptoByWalletIdAndCurrencyName(int walletId , string currencyName)
    {
        return await _context.CryptoCurrencies.FirstOrDefaultAsync(c => c.WalletId == walletId && c.CurrencyName == currencyName);
    }
    public async Task<CryptoCurrency> GetCryptoByWalletIdAndAbbreviationName(int walletId, string currencyabbreviation)
    {
        return await _context.CryptoCurrencies.FirstOrDefaultAsync(c => c.WalletId == walletId && c.CurrencyCode == currencyabbreviation);
    }

    public async Task UpdateCrypto(CryptoCurrency cryptoCurrency)
    {
        _context.CryptoCurrencies.Update(cryptoCurrency);
        await _context.SaveChangesAsync();
    }
}
