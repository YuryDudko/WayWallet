

using Domain;
using MediatR;

namespace Application.GetCryptoListRequests;

public class GetCryptoListRequestHandler : IRequestHandler<GetCryptoListRequest, IEnumerable<CryptoCurrency>>
{
    private readonly IWalletRepository _walletRepository;
    private readonly ICryptoCurrencyRepository _cryptoCurrencyRepository;

    public GetCryptoListRequestHandler(IWalletRepository walletRepository, ICryptoCurrencyRepository cryptoCurrencyRepository)
    {
        _walletRepository = walletRepository;
        _cryptoCurrencyRepository = cryptoCurrencyRepository;
    }

    public async Task<IEnumerable<CryptoCurrency>> Handle(GetCryptoListRequest request, CancellationToken cancellationToken)
    {
        var wallet = await _walletRepository.GetWalletByUserId(request.UserId);
        if (wallet == null)
        {
            return new List<CryptoCurrency>(); // Если кошелек не найден, возвращаем пустой список
        }

        var cryptocurrencies = await _cryptoCurrencyRepository.GetCryptocurrenciesByWalletId(wallet.Id);
        return cryptocurrencies;
    }
}
