

using Microsoft.Extensions.DependencyInjection;

namespace Application.TransferRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddWalletAdditionHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(TransferCryptoRequest).Assembly));
        return services;
    }
}
