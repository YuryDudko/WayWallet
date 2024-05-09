using Application.LoginRequests;
using Domain;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace WebApplication1.Controllers;

public class LoginController (IMediator mediator, IUserRepository userRepository) : Controller
{
    [HttpPost("/Login")]
    public async Task<IActionResult> LoginUser([FromBody] LoginUserRequest user)
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
