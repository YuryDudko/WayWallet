
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
}
