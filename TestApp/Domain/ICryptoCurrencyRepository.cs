
namespace Domain;

public interface ICryptoCurrencyRepository
{
    public Task AddCryptoCurrencyAsync(CryptoCurrency currency);
}
