
using Domain;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure;

public class PurchaseRepositoryLocalStorage : IPurchaseRepository
{
    private readonly AppDbContext _context;

    public PurchaseRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddPurchaseAsync(Purchase purchase)
    {
        await _context.Purchases.AddAsync(purchase);
        await _context.SaveChangesAsync();
    }

    public async Task<int> GetNextPurchaseIdAsync()
    {
        return await _context.Purchases.CountAsync() + 1;
    }

    public async Task<IEnumerable<Purchase>> GetPurchasesByAddresses(IEnumerable<string> addresses)
    {
        return await _context.Purchases
            .Where(s => addresses.Contains(s.ReceiverAdress))
            .ToListAsync();
    }
}
