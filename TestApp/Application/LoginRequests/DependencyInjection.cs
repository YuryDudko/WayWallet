using Application.RegistrationRequests;
using Microsoft.Extensions.DependencyInjection;

namespace Application.LoginRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddLoginHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(LoginUserRequest).Assembly));
        return services;
    }
}
