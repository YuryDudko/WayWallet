using Domain;
using MediatR;

namespace Application.WalletAdditionRequests;

public sealed record WalletAdditionRequest : IRequest<Wallet>
{
    public string walletName { get; set; }
    public string keyPhrase { get; set; }
    public int UserId { get; set; }
}
