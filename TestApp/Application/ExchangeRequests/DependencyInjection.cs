using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.ExchangeRequests;

public static class DependencyInjection
{
    public static IServiceCollection PurchaseHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(ExchangeRequest).Assembly));
        return services;
    }
}
