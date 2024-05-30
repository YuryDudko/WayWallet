using MediatR;
using Domain;

namespace Application.UserInfoRequests;

public sealed record UserInfoRequest(int UserId, string RoleClaim) : IRequest<UserInfo>;

