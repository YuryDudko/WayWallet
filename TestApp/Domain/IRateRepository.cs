

namespace Domain;

public interface IRateRepository
{
    Task<IEnumerable<Rate>> GetAllRatesAsync();
    Task<Rate> GetRateByIdAsync(int? id);
    Task UpdateRatesAsync(List<Rate> rates);
    Task UpdateRatesFromApiAsync();
}

