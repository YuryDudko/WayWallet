using Domain;
using MediatR;

namespace Application.GetCryptoListRequests;

//public sealed record GetCryptoListRequest : IRequest<CryptoCurrency>
//{

//}
public sealed record GetCryptoListRequest(int UserId) : IRequest<IEnumerable<CryptoCurrency>>;
