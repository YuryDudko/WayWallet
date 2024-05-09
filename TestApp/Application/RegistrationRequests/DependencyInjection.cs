using Microsoft.Extensions.DependencyInjection;

namespace Application.RegistrationRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(RegisterUserRequest).Assembly));
        return services;
    }
}
