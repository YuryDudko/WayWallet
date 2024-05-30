using Application.GetNetworkListRequests;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class NetworkInfoController(IMediator mediator) : Controller
{
    [HttpGet("/GetNetworkInfo")]
    public async Task<IActionResult> GetNetworkInfo()
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

            var request = new NetworkListRequest(userId);
            var networksInfo = await mediator.Send(request);
            return Ok(networksInfo!);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
