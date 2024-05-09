using Domain;
using MediatR;

namespace Application.LoginRequests;

public class LoginUserRequestHandler(IUserRepository userRepository) : IRequestHandler<LoginUserRequest , User>
{
    public async Task<User> Handle(LoginUserRequest request , CancellationToken cancellationToken)
    {
        //request.userName = request.userName ?? string.Empty;
        if (request == null || string.IsNullOrEmpty(request.login) || string.IsNullOrEmpty(request.password))
        {
            throw new NullUserException();
        }
        var existingUsernameUser = userRepository.GetUserByUsernameAndPassword(request.login , request.password);
        if (existingUsernameUser == null)
        {
            var existingEmailUser = userRepository.GetUserByEmailAndPassword(request.login , request.password);
            if(existingEmailUser == null)
            {
                throw new UserNotFoundException();
            }

            return existingEmailUser;
        }
        return existingUsernameUser;

    }
}
