
using Microsoft.EntityFrameworkCore;
using Domain;

namespace Infrastructure;

public class NetworkRepositoryLocalStorage : INetworkRepository
{
    private readonly AppDbContext _context;

    public NetworkRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Network>> GetNetworksAsync()
    {
        await UpdateNetworkLoadAndGasAsync();
        return await _context.Networks.ToListAsync();
    }

    public async Task UpdateNetworkLoadAndGasAsync()
    {
        var networks = await _context.Networks.ToListAsync();
        var random = new Random();

        foreach (var network in networks)
        {
            network.NetworkLoad = random.Next(0, 101);
            network.NetworkGas = CalculateGasFee(network.NetworkLoad);
        }

        await _context.SaveChangesAsync();
    }

    private double CalculateGasFee(int networkLoad)
    {
        if (networkLoad < 30)
        {
            return 4.0; // Low fee
        }
        else if (networkLoad < 70)
        {
            return 6.5; // Medium fee
        }
        else
        {
            return 10.0; // High fee
        }
    }
}
