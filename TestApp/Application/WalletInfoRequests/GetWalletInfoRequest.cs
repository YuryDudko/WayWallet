using Domain;
using MediatR;

namespace Application.WalletInfoRequests;

public sealed record GetWalletInfoRequest(int userId) : IRequest<WalletInfo>;

