
namespace Domain;

public interface ISaleRepository
{
    public Task AddSaleAsync(Sale sale);
    public Task<int> GetNextSaleIdAsync();
    Task<IEnumerable<Sale>> GetSalesByAddresses(IEnumerable<string> addresses);
}
