
using Domain;
using MediatR;

namespace Application.TransferRequests;

public class TransferHandler(IWalletRepository walletRepository, ITransferRepository transferRepository, ICryptoCurrencyRepository cryptoCurrencyRepository) : IRequestHandler<TransferCryptoCommand>
{
    public async Task Handle(TransferCryptoCommand request, CancellationToken cancellationToken)
    {
        var senderWallet = await walletRepository.GetWalletByUserId(request.UserId);
        var senderCryptocur = await cryptoCurrencyRepository.GetCryptoByWalletIdAndCurrencyName(senderWallet.Id, request.Currency);
        if (senderWallet == null)
        {
            throw new Exception("Sender wallet not found.");
        }
        if (senderCryptocur == null)
        {
            throw new Exception("Sender currency not found");
        }

        var recipientCrypto = await cryptoCurrencyRepository.GetCryptoByAddress(request.RecipientAddress);
        if (recipientCrypto == null)
        {
            throw new Exception("Recipient address not found."+request.RecipientAddress);
        }

        // Увеличение баланса получателя
        recipientCrypto.CurrencyAmount += request.Amount;
        senderCryptocur.CurrencyAmount -= request.Amount;
        await cryptoCurrencyRepository.UpdateCrypto(recipientCrypto);
        await cryptoCurrencyRepository.UpdateCrypto(senderCryptocur);

        // Создание записи о трансфере
        var transferId = await transferRepository.GetNextTransferIdAsync();
        var transfer = new Transfer
        {
            Name = "Transfer" + transferId,
            DateTime = DateTime.UtcNow,
            SenderAdress = senderCryptocur.CurrencyAdress,
            ClaimerAdress = recipientCrypto.CurrencyAdress,
            TransferAmount = request.Amount,
            CryptoAbbreviation = senderCryptocur.CurrencyCode,
        };

        await transferRepository.AddTransferAsync(transfer);

        return;
    }
}
