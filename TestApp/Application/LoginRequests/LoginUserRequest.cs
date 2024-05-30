using Domain;
using MediatR;

namespace Application.LoginRequests;

public sealed record LoginUserRequest: IRequest<LoginResponse>
{
    public string login { get; set; }
    public string password { get; set; }
}
