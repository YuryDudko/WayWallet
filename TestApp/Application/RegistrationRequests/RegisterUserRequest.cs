using Domain;
using MediatR;

namespace Application.RegistrationRequests;

public sealed record RegisterUserRequest : IRequest<User>
{
    public string userName { get; set; }
    public string password { get; set; }
    public string email { get; set; }
}
