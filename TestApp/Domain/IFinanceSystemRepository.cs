using Microsoft.EntityFrameworkCore;

namespace Domain;

public interface IFinanceSystemRepository
{
    public Task AddFinanceSystemAsync(FinanceSystem financeSystem);
    public Task<FinanceSystem> GetSystem(int SystemId);
    public Task UpdateSystem(FinanceSystem financeSystem);
    
}
