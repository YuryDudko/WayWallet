using Domain;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddRepositories(this IServiceCollection services)
    {
        services.AddSingleton<IUserRepository, UserRepositoryLocalStorage>();
        services.AddSingleton<IWalletRepository, WalletRepositoryLocalStorage>();
        return services;
    }


}
