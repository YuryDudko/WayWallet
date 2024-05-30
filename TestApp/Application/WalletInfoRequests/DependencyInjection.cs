using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.WalletInfoRequests;

public static class DependencyInjection
{
    public static IServiceCollection AddWalletAdditionHandler(this IServiceCollection services)
    {
        services.AddMediatR(cnf => cnf.RegisterServicesFromAssembly(typeof(GetWalletInfoRequest).Assembly));
        return services;
    }
}
