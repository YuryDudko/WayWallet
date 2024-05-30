

using Microsoft.Extensions.DependencyInjection;

namespace Application.NewsRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddNewsHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(CreateNewsRequest).Assembly));
        return services;
    }
}
