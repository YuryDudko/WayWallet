
using Domain;
using MediatR;

namespace Application.WalletAdditionRequests;

public class WalletAdditionRequestHandler (IWalletRepository walletRepository, IUserRepository userRepository , ICryptoCurrencyRepository cryptoCurrencyRepository) : IRequestHandler<WalletAdditionRequest, Wallet>
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

        var cryptoCurrency = new CryptoCurrency();
        cryptoCurrency.CurrencyName = "Bitcoin";
        cryptoCurrency.CurrencyAmount = 2.34;
        cryptoCurrency.WalletId = wallet.Id;
        cryptoCurrency.RateId = 1;
        cryptoCurrency.CurrencyAdress = "adress";
        cryptoCurrency.CurrencyCode = "BTC";
        //proba izmenit
        await cryptoCurrencyRepository.AddCryptoCurrencyAsync(cryptoCurrency);

        return wallet;
    }
}
