using Domain;
using MediatR;

namespace Application.GetTransactionHistoryRequests;

public class GetTransactionHistoryRequestHandler(IWalletRepository walletRepository,ICryptoCurrencyRepository cryptoCurrencyRepository,ISaleRepository saleRepository,IPurchaseRepository purchaseRepository,ITransferRepository transferRepository) : IRequestHandler<GetTransactionHistoryRequest, IEnumerable<TransactionHistory>>
{

    public async Task<IEnumerable<TransactionHistory>> Handle(GetTransactionHistoryRequest request, CancellationToken cancellationToken)
    {
        var wallet = await walletRepository.GetWalletByUserId(request.UserId);
        if (wallet == null)
        {
            throw new Exception("Wallet not found.");
        }

        var cryptocurrencies = await cryptoCurrencyRepository.GetCryptocurrenciesByWalletId(wallet.Id);
        var cryptoAddresses = cryptocurrencies.Select(c => c.CurrencyAdress).ToList();

        var sales = await saleRepository.GetSalesByAddresses(cryptoAddresses);
        var purchases = await purchaseRepository.GetPurchasesByAddresses(cryptoAddresses);
        var transfers = await transferRepository.GetTransfersByAddresses(cryptoAddresses);

        var history = new List<TransactionHistory>();

        history.AddRange(sales.Select(s => new TransactionHistory
        {
            TransactionType = "Sale",
            TransactionDate = s.OrderDate,
            CryptoAbbreviation = s.CryptoAbbreviation,
            Amount = s.OrderAmount,
            Address = s.SenderAdress,
            EquivalentAmount = s.SaleAmount
        }));

        history.AddRange(purchases.Select(p => new TransactionHistory
        {
            TransactionType = "Purchase",
            TransactionDate = p.OrderDate,
            CryptoAbbreviation = p.CryptoAbbreviation,
            Amount = p.OrderAmount,
            Address = p.ReceiverAdress,
            EquivalentAmount = p.PurchaseAmount
        }));

        history.AddRange(transfers.Select(t => new TransactionHistory
        {
            TransactionType = "Transfer",
            TransactionDate = t.DateTime,
            CryptoAbbreviation = t.CryptoAbbreviation, // Assuming transfers don't have a specific crypto abbreviation
            Amount = t.TransferAmount,
            Address = t.SenderAdress,
            EquivalentAmount = 0 // Transfers might not have an equivalent USD amount
        }));

        return history;
    }
}