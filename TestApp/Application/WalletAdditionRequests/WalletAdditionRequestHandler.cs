
using Domain;
using MediatR;

namespace Application.WalletAdditionRequests;

public class WalletAdditionRequestHandler (IWalletRepository walletRepository, IUserRepository userRepository , ICryptoCurrencyRepository cryptoCurrencyRepository , IRateRepository rateRepository) : IRequestHandler<WalletAdditionRequest, Wallet>
{
    public async Task<Wallet> Handle(WalletAdditionRequest request, CancellationToken cancellationToken)
    {
        if (request == null || string.IsNullOrEmpty(request.walletName) || string.IsNullOrEmpty(request.keyPhrase) || string.IsNullOrEmpty(request.UserName))
        {
            throw new NullWalletException();
        }
        var wallet = new Wallet();
        
        wallet.WalletName = request.walletName;
        wallet.KeyPhrase = request.keyPhrase;
        var user =  userRepository.GetUserByName(request.UserName);
        wallet.UserId = user.Id;
        await walletRepository.AddWalletAsync(wallet);

        var rates = await rateRepository.GetAllRatesAsync();
        var firstSevenRates = rates.Take(7).ToList();

        foreach (var rate in firstSevenRates)
        {
            var cryptoCurrency = new CryptoCurrency
            {
                CurrencyName = rate.Name,
                CurrencyAmount = 0.0,
                WalletId = wallet.Id,
                RateId = rate.Id,
                CurrencyAdress = GenerateRandomAddress(),
                CurrencyCode = rate.Symbol
            };

            await cryptoCurrencyRepository.AddCryptoCurrencyAsync(cryptoCurrency);
        }


        return wallet;
    }

    private string GenerateRandomAddress()
    {
        var random = new Random();
        const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        return new string(Enumerable.Repeat(chars, 24).Select(s => s[random.Next(s.Length)]).ToArray());
    }
}
