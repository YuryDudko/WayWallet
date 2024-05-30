

namespace Domain;

public interface IExchangeRepository
{
    Task AddExchangeAsync(Exchange exchange);
    Task<int> GetNextExchangeIdAsync();
}

