using Application.UserInfoRequests;
using MediatR;
using Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class GetUserInfoController : Controller
{
    private readonly IMediator mediator;

    public GetUserInfoController(IMediator mediator)
    {
        this.mediator = mediator;
    }

    [HttpGet("/GetUserInfo")]
    public async Task<IActionResult> GetUserInfo()
    {
        try
        {
            var userIdClaim = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            if (userIdClaim == null)
            {
                return Unauthorized("User ID not found in token.");
            }

            if (!int.TryParse(userIdClaim.Value, out int userId))
            {
                return BadRequest("Invalid User ID in token." + userIdClaim.Value);
            }
            var roleClaim = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role);
            if (roleClaim == null)
            {
                return Unauthorized("User role not found in token.");
            }

            var request = new UserInfoRequest(userId, roleClaim.Value);
            var userInfo = await mediator.Send(request);

            return Ok(userInfo!);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}

