

using Domain;
using MediatR;

namespace Application.RateRequests;

public class RateUpdateRequestHandler : IRequestHandler<RateUpdateRequest>
{
    private readonly IRateRepository _rateRepository;

    public RateUpdateRequestHandler(IRateRepository rateRepository)
    {
        _rateRepository = rateRepository;
    }

    public async Task Handle(RateUpdateRequest request, CancellationToken cancellationToken)
    {
        await _rateRepository.UpdateRatesFromApiAsync();
        return;
    }
}


public class GetRatesRequestHandler(IWalletRepository _walletRepository , ICryptoCurrencyRepository _cryptoCurrencyRepository , IRateRepository _rateRepository) : IRequestHandler<GetRatesRequest, IEnumerable<Rate>>
{
    public async Task<IEnumerable<Rate>> Handle(GetRatesRequest request, CancellationToken cancellationToken)
    {
        var wallet = await _walletRepository.GetWalletByUserId(request.UserId);
        if (wallet == null)
        {
            return new List<Rate>(); // Если кошелек не найден, возвращаем пустой список
        }

        var cryptocurrencies = await _cryptoCurrencyRepository.GetCryptocurrenciesByWalletId(wallet.Id);
        if (cryptocurrencies == null || !cryptocurrencies.Any())
        {
            return new List<Rate>(); // Если криптовалюты не найдены, возвращаем пустой список
        }

        var rates = new List<Rate>();
        foreach (var crypto in cryptocurrencies)
        {
            var rate = await _rateRepository.GetRateByIdAsync(crypto.RateId);
            if (rate != null)
            {
                rates.Add(rate);
            }
        }

        return rates;
    }
}




