
using Domain;
using Microsoft.EntityFrameworkCore;
using System.Runtime.Loader;

namespace Infrastructure;

public class TransferRepositoryLocalStorage: ITransferRepository
{
    private readonly AppDbContext _context;

    public TransferRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddTransferAsync(Transfer transfer)
    {
        await _context.Transfers.AddAsync(transfer);
        await _context.SaveChangesAsync();
    }

    public async Task<int> GetNextTransferIdAsync()
    {
        return await _context.Transfers.CountAsync() + 1;
    }

    public async Task<IEnumerable<Transfer>> GetTransfersByAddresses(IEnumerable<string> addresses)
    {
        return await _context.Transfers
            .Where(s => addresses.Contains(s.ClaimerAdress) || addresses.Contains(s.SenderAdress))
            .ToListAsync();
    }
}
