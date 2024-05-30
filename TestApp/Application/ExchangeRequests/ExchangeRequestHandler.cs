

using Domain;
using MediatR;

namespace Application.ExchangeRequests;

public class ExchangeRequestHandler(IWalletRepository walletRepository, ICryptoCurrencyRepository cryptoCurrencyRepository, IExchangeRepository exchangeRepository) : IRequestHandler<ExchangeRequestCommand>
{
    public async Task Handle(ExchangeRequestCommand request, CancellationToken cancellationToken)
    {
        var userWallet = await walletRepository.GetWalletByUserId(request.UserId);
        if (userWallet == null)
        {
            throw new Exception("User wallet not found.");
        }

        var cryptoFirst = await cryptoCurrencyRepository.GetCryptoByWalletIdAndAbbreviationName(userWallet.Id, request.CryptocurrencyAbbreviationFirst);
        var cryptoSecond = await cryptoCurrencyRepository.GetCryptoByWalletIdAndAbbreviationName(userWallet.Id, request.CryptocurrencyAbbreviationSecond);

        if (cryptoFirst == null || cryptoSecond == null)
        {
            throw new Exception("Cryptocurrency not found.");
        }

        if (cryptoFirst.CurrencyAmount < request.ExchangeAmountFirst)
        {
            throw new Exception("Insufficient balance.");
        }

        cryptoFirst.CurrencyAmount -= request.ExchangeAmountFirst;
        cryptoSecond.CurrencyAmount += request.ExchangeAmountSecond;

        await cryptoCurrencyRepository.UpdateCrypto(cryptoFirst);
        await cryptoCurrencyRepository.UpdateCrypto(cryptoSecond);
        var exchangeId = await exchangeRepository.GetNextExchangeIdAsync();

        var exchange = new Exchange
        {
            UserId = request.UserId,
            ExchangeName = "Exchange" + exchangeId,
            CryptocurrencyAbbreviationFirst = request.CryptocurrencyAbbreviationFirst,
            ExchangeAmountFirst = request.ExchangeAmountFirst,
            CryptocurrencyAbbreviationSecond = request.CryptocurrencyAbbreviationSecond,
            ExchangeAmountSecond = request.ExchangeAmountSecond,
            ExchangeDate = DateTime.UtcNow,
        };

        await exchangeRepository.AddExchangeAsync(exchange);
    }
}
