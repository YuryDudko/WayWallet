

namespace Domain;

public interface INetworkRepository
{
    public Task<IEnumerable<Network>> GetNetworksAsync();
    Task UpdateNetworkLoadAndGasAsync();
}

