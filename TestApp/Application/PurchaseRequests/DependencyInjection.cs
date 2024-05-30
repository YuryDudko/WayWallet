
using Microsoft.Extensions.DependencyInjection;

namespace Application.PurchaseRequests;

public static class DependencyInjection
{
    public static IServiceCollection PurchaseHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(PurchaseRequest).Assembly));
        return services;
    }
}
