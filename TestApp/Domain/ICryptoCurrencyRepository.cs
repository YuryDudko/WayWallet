
namespace Domain;

public interface ICryptoCurrencyRepository
{
    public Task AddCryptoCurrencyAsync(CryptoCurrency currency);
    public Task<List<CryptoCurrency>> GetCryptocurrenciesByWalletId(int walletId);
    public Task<CryptoCurrency> GetCryptoByAddress(string address);
    public Task UpdateCrypto(CryptoCurrency cryptoCurrency);
    public Task<CryptoCurrency> GetCryptoByWalletIdAndCurrencyName(int walletId, string currencyName);
    public Task<CryptoCurrency> GetCryptoByWalletIdAndAbbreviationName(int walletId, string currencyabbreviation);
}
