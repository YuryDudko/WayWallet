

using Microsoft.Extensions.DependencyInjection;

namespace Application.GetNetworkListRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddCryptoListGetterHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(NetworkListRequest).Assembly));
        return services;
    }
}
