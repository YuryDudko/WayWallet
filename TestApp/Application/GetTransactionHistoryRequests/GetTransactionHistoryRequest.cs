
using Domain;
using MediatR;

namespace Application.GetTransactionHistoryRequests;

public sealed record GetTransactionHistoryRequest(int UserId) : IRequest<IEnumerable<TransactionHistory>>;
