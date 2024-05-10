using Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddRepositories(this IServiceCollection services)
    {
        services.AddTransient<IUserRepository, UserRepositoryLocalStorage>();
        services.AddTransient<IWalletRepository, WalletRepositoryLocalStorage>();
        services.AddTransient<ICryptoCurrencyRepository, CryptoCurrencyRepositoryLocalStorage>();
        services.AddDbContext<AppDbContext>(options => options.UseSqlite("Data Source=Database.db"));
        return services;
    }


}
