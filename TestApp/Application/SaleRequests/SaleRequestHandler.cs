using Domain;
using MediatR;

namespace Application.SaleRequests;

public class SaleRequestHandler(IWalletRepository walletRepository, ISaleRepository saleRepository, ICryptoCurrencyRepository cryptoCurrencyRepository, IFinanceSystemRepository financeSystemRepository) : IRequestHandler<SaleRequestCommand>
{
    public async Task Handle(SaleRequestCommand request, CancellationToken cancellationToken)
    {
        var senderWallet = await walletRepository.GetWalletByUserId(request.UserId);
        var senderCryptocur = await cryptoCurrencyRepository.GetCryptoByWalletIdAndAbbreviationName(senderWallet.Id, request.CryptoAbbreviation);
        if (senderWallet == null)
        {
            throw new Exception("Receiver wallet not found.");
        }
        if (senderCryptocur == null)
        {
            throw new Exception("Receiver currency not found");
        }

        var financialSystem = await financeSystemRepository.GetSystem(1);
        if (financialSystem == null)
        {
            throw new Exception("Financial system not found");
        }
        senderWallet.WalletBalance += request.OrderAmount * request.SaleRateValue;
        senderCryptocur.CurrencyAmount -= request.OrderAmount;
        financialSystem.Balance += request.OrderAmount * request.SaleRateValue;
        await cryptoCurrencyRepository.UpdateCrypto(senderCryptocur);
        await financeSystemRepository.UpdateSystem(financialSystem);

        var saleId = await saleRepository.GetNextSaleIdAsync();
        var sale = new Sale
        {
            Name = "Sale" + saleId,
            OrderDate = DateTime.UtcNow,
            SenderAdress = senderCryptocur.CurrencyAdress,
            CryptoAbbreviation = request.CryptoAbbreviation,
            OrderAmount = request.OrderAmount,
            SaleRateValue = request.SaleRateValue,
            SaleAmount = request.OrderAmount * request.SaleRateValue,
            FinanceSystemId = financialSystem.Id,

        };

        await saleRepository.AddSaleAsync(sale);

        return;

    }
}
