

using Application.WalletInfoRequests;
using Domain;
using MediatR;

namespace Application.GetNetworkListRequests;

public class NetworkInfoRequestHandler(INetworkRepository networkRepository) : IRequestHandler<NetworkListRequest, IEnumerable<Network>>
{
    public async Task<IEnumerable<Network>> Handle(NetworkListRequest request, CancellationToken cancellationToken)
    {
        return await networkRepository.GetNetworksAsync();
    }
}
