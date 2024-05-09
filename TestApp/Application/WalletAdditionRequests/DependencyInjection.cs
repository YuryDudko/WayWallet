using Microsoft.Extensions.DependencyInjection;

namespace Application.WalletAdditionRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddWalletAdditionHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(WalletAdditionRequest).Assembly));
        return services;
    }
}
