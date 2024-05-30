using Domain;
using MediatR;
using Microsoft.Extensions.Configuration;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;

namespace Application.LoginRequests;

public class LoginUserRequestHandler : IRequestHandler<LoginUserRequest, LoginResponse>
{
    private readonly IUserRepository userRepository;
    private readonly IWalletRepository walletRepository;
    private readonly IConfiguration configuration;

    public LoginUserRequestHandler(IUserRepository userRepository, IWalletRepository walletRepository, IConfiguration configuration)
    {
        this.userRepository = userRepository;
        this.walletRepository = walletRepository;
        this.configuration = configuration;
    }

    public async Task<LoginResponse> Handle(LoginUserRequest request, CancellationToken cancellationToken)
    {
        if (request == null || string.IsNullOrEmpty(request.login) || string.IsNullOrEmpty(request.password))
        {
            throw new NullUserException();
        }

        var user = await userRepository.GetUserByUsernameAndPasswordAsync(request.login, request.password) ??
                   await userRepository.GetUserByEmailAndPasswordAsync(request.login, request.password);

        if (user == null)
        {
            throw new UserNotFoundException();
        }

        var token = GenerateJwtToken(user);
        var wallet = await walletRepository.GetWalletByUserId(user.Id);
        bool hasWallet = false;
        if(wallet != null)
        {
            hasWallet = true;
        }
        //bool hasWallet = wallet != null;

        return new LoginResponse { Token = token, HasWallet = hasWallet };
    }

    private string GenerateJwtToken(User user)
    {
        var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Key"]));
        var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new Claim(ClaimTypes.Role, user.Role.ToString()),
            new Claim(JwtRegisteredClaimNames.Sub, user.Username),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            
        };

        var token = new JwtSecurityToken(
            issuer: configuration["Jwt:Issuer"],
            audience: configuration["Jwt:Audience"],
            claims: claims,
            expires: DateTime.Now.AddMinutes(120),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
