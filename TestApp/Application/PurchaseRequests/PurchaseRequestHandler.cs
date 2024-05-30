using Domain;
using MediatR;

namespace Application.PurchaseRequests;

public class PurchaseRequestHandler(IWalletRepository walletRepository, IPurchaseRepository purchaseRepository, ICryptoCurrencyRepository cryptoCurrencyRepository , IFinanceSystemRepository financeSystemRepository) : IRequestHandler<PurchaseRequestCommand>
{
    public async Task Handle(PurchaseRequestCommand request, CancellationToken cancellationToken)
    {
        var receiverWallet = await walletRepository.GetWalletByUserId(request.UserId);
        var receiverCryptocur = await cryptoCurrencyRepository.GetCryptoByWalletIdAndAbbreviationName(receiverWallet.Id, request.CryptoAbbreviation);
        if (receiverWallet == null)
        {
            throw new Exception("Receiver wallet not found.");
        }
        if (receiverCryptocur == null)
        {
            throw new Exception("Receiver currency not found");
        }

        var financialSystem = await financeSystemRepository.GetSystem(1);
        if (financialSystem == null)
        {
            throw new Exception("Financial system not found");
        }

        receiverCryptocur.CurrencyAmount += request.OrderAmount;
        receiverWallet.WalletBalance -= request.OrderAmount * request.PurchaseRateValue;
        financialSystem.Balance -= request.OrderAmount * request.PurchaseRateValue;
        await cryptoCurrencyRepository.UpdateCrypto(receiverCryptocur);
        await financeSystemRepository.UpdateSystem(financialSystem);

        var purchaseId = await purchaseRepository.GetNextPurchaseIdAsync();
        var purchase = new Purchase
        {
            Name = "Purchase" + purchaseId,
            OrderDate = DateTime.UtcNow,
            ReceiverAdress = receiverCryptocur.CurrencyAdress,
            CryptoAbbreviation = request.CryptoAbbreviation,
            OrderAmount = request.OrderAmount,
            PurchaseRateValue = request.PurchaseRateValue,
            PurchaseAmount = request.OrderAmount * request.PurchaseRateValue,
            FinanceSystemId = financialSystem.Id,

        };

        await purchaseRepository.AddPurchaseAsync(purchase);

        return;

    }
}
