

using Domain;
using MediatR;

namespace Application.UserInfoRequests;

public class UserInfoRequestHandler(IUserRepository userRepository) : IRequestHandler<UserInfoRequest, UserInfo>
{
    public async Task<UserInfo> Handle(UserInfoRequest request, CancellationToken cancellationToken)
    {
        var user = await userRepository.GetUserByIdAsync(request.UserId);

        if (user == null)
        {
            throw new UserNotFoundException();
        }

        return new UserInfo
        {
            Id = user.Id,
            Username = user.Username,
            Password = user.Password,
            Email = user.Email,
            RoleName = request.RoleClaim,

        };
    }
}

