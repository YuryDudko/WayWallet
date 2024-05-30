

using Domain;
using MediatR;

namespace Application.WalletInfoRequests;

public class GetWalletInfoRequestHandler(IWalletRepository walletRepository) : IRequestHandler<GetWalletInfoRequest, WalletInfo>
{
    public async Task<WalletInfo> Handle(GetWalletInfoRequest request, CancellationToken cancellationToken)
    {
        var wallet = await walletRepository.GetWalletByUserId(request.userId);

        if (wallet == null)
        {
            throw new WalletNotFoundException();
        }

        return new WalletInfo
        {
            WalletName = wallet.WalletName,
            WalletBalance = wallet.WalletBalance,
            KeyPhrase = wallet.KeyPhrase
        };
    }
}

