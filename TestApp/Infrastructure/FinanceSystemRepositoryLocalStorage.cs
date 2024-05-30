using Domain;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure;

public class FinanceSystemRepositoryLocalStorage: IFinanceSystemRepository
{
    private readonly AppDbContext _context;

    public FinanceSystemRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddFinanceSystemAsync(FinanceSystem financeSystem)
    {
        _context.FinanceSystems.Add(financeSystem);
        await _context.SaveChangesAsync();
    }
    public async Task<FinanceSystem> GetSystem(int SystemId)
    {
        return await _context.FinanceSystems.FirstOrDefaultAsync(c => c.Id == SystemId);
    }

    public async Task UpdateSystem(FinanceSystem financeSystem)
    {
        _context.FinanceSystems.Update(financeSystem);
        await _context.SaveChangesAsync();
    }
}
