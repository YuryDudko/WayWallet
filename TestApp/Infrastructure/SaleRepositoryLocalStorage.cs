

using Domain;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure;

public class SaleRepositoryLocalStorage: ISaleRepository
{
    private readonly AppDbContext _context;

    public SaleRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddSaleAsync(Sale sale)
    {
        await _context.Sales.AddAsync(sale);
        await _context.SaveChangesAsync();
    }

    public async Task<int> GetNextSaleIdAsync()
    {
        return await _context.Sales.CountAsync() + 1;
    }

    public async Task<IEnumerable<Sale>> GetSalesByAddresses(IEnumerable<string> addresses)
    {
        return await _context.Sales
            .Where(s => addresses.Contains(s.SenderAdress))
            .ToListAsync();
    }
}
