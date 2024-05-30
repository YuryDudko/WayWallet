

using Microsoft.EntityFrameworkCore;

namespace Domain;

public interface IPurchaseRepository
{
    public Task AddPurchaseAsync(Purchase purchase);
    public Task<int> GetNextPurchaseIdAsync();
    Task<IEnumerable<Purchase>> GetPurchasesByAddresses(IEnumerable<string> addresses);
}
