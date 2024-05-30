
using Domain;
using MediatR;

namespace Application.TransferRequests;

public sealed record TransferCryptoCommand : IRequest
{
    public int UserId { get; }
    public string RecipientAddress { get; }
    public string Currency { get; }
    public string Network { get; }
    public double Amount { get; }

    public TransferCryptoCommand(int userId, string recipientAddress, string currency, string network, double amount)
    {
        UserId = userId;
        RecipientAddress = recipientAddress;
        Currency = currency;
        Network = network;
        Amount = amount;
    }
};

public sealed record TransferCryptoRequest : IRequest<Transfer>
{
    public string RecipientAddress { get; set; }
    public string Currency { get; set; }
    public string Network { get; set; }
    public double Amount { get; set; }
}
