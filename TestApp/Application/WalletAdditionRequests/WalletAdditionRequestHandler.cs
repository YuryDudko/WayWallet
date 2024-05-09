
using Domain;
using MediatR;

namespace Application.WalletAdditionRequests;

public class WalletAdditionRequestHandler (IWalletRepository walletRepository, IUserRepository userRepository) : IRequestHandler<WalletAdditionRequest, Wallet>
{
    public async Task<Wallet> Handle(WalletAdditionRequest request, CancellationToken cancellationToken)
    {
        if (request == null || string.IsNullOrEmpty(request.walletName) || string.IsNullOrEmpty(request.keyPhrase))
        {
            throw new NullWalletException();
        }
        var wallet = new Wallet();
        wallet.WalletName = request.walletName;
        wallet.KeyPhrase = request.keyPhrase;
        wallet.WalletUser = userRepository.GetUserById(request.UserId);
        walletRepository.AddWalletAsync(wallet);
        return wallet;
    }
}
