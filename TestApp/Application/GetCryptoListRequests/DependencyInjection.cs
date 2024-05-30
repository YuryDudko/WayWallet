using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.GetCryptoListRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddCryptoListGetterHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(GetCryptoListRequest).Assembly));
        return services;
    }
}
