using Domain;
using MediatR;

namespace Application.RegistrationRequests;

public class RegisterUserRequestHandler(IUserRepository userRepository) : IRequestHandler<RegisterUserRequest, User>
{
    public async Task<User> Handle(RegisterUserRequest request, CancellationToken cancellationToken)
    {
        request.userName = request.userName ?? string.Empty;
        if (request == null || string.IsNullOrEmpty(request.userName) || string.IsNullOrEmpty(request.password) || string.IsNullOrEmpty(request.email))
        {
            throw new NullUserException();
        }
        
        var user = new User();
        user.Username = request.userName;
        if (user.Username.ToLower() == "admin")
        {
            user.Role = UserRole.Admin;
        }
        else
        {
            user.Role = UserRole.CommonUser;
        }
        user.Password = request.password;
        user.Email = request.email;
        await userRepository.AddUserAsync(user);

        return user;
    }
}
