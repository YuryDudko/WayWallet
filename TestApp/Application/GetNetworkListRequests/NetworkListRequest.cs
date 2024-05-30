

using Domain;
using MediatR;

namespace Application.GetNetworkListRequests;

public sealed record NetworkListRequest(int UserId) : IRequest<IEnumerable<Network>>;
