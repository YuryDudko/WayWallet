using Microsoft.Extensions.DependencyInjection;


namespace Application.UserInfoRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddWalletAdditionHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(UserInfoRequest).Assembly));
        return services;
    }
}
