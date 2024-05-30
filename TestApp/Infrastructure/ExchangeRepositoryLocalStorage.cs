
using Microsoft.EntityFrameworkCore;
using Domain;

namespace Infrastructure;

public class ExchangeRepositoryLocalStorage : IExchangeRepository
{
    private readonly AppDbContext _context;

    public ExchangeRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddExchangeAsync(Exchange exchange)
    {
        await _context.Exchanges.AddAsync(exchange);
        await _context.SaveChangesAsync();
    }

    public async Task<int> GetNextExchangeIdAsync()
    {
        return await _context.Exchanges.CountAsync() + 1;
    }

    public async Task<IEnumerable<Exchange>> GetExchangesByUserId(int userId)
    {
        return await _context.Exchanges
            .Where(e => e.UserId == userId)
            .ToListAsync();
    }
}


