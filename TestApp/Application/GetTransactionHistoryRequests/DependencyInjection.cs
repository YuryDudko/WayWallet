using Microsoft.Extensions.DependencyInjection;

namespace Application.GetTransactionHistoryRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddCryptoListGetterHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(GetTransactionHistoryRequest).Assembly));
        return services;
    }
}
