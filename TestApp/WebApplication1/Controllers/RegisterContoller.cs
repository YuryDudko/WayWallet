using Application.RegistrationRequests;
using Domain;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace WebApplication1.Controllers;

public class RegisterContoller(IMediator mediator, IUserRepository userRepository) : Controller
{
    [HttpPost("/Register")]
    public async Task<IActionResult> RegisterUser([FromBody] RegisterUserRequest user)
    {
        try
        {
            var res = await mediator.Send(user);

            return Ok(res!);
        }
        catch (UserNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (Exception ex) 
        {
            return BadRequest(ex.Message);
        }
    }
}
