using Domain;
using MediatR;

namespace Application.RateRequests;

public sealed record RateUpdateRequest : IRequest;

public sealed record GetRatesRequest(int UserId) : IRequest<IEnumerable<Rate>>;
