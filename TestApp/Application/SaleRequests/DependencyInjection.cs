using Microsoft.Extensions.DependencyInjection;

namespace Application.SaleRequests;

public static class DependencyInjection
{
    public static IServiceCollection PurchaseHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(SaleRequest).Assembly));
        return services;
    }
}
