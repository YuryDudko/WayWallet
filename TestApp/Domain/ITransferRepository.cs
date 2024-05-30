

namespace Domain;

public interface ITransferRepository
{
    public Task AddTransferAsync(Transfer transfer);
    public Task<int> GetNextTransferIdAsync();
    Task<IEnumerable<Transfer>> GetTransfersByAddresses(IEnumerable<string> addresses);
}
