using Application.RateRequests;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class RateUpdateController(IMediator mediator) : Controller
{
    [HttpPost("/UpdateRates")]
    public async Task<IActionResult> UpdateRates()
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
                return BadRequest("Invalid User ID in token.");
            }

            var request = new RateUpdateRequest();
            await mediator.Send(request);
            return Ok("Rates updated successfully.");
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpGet("/GetRates")]
    public async Task<IActionResult> GetRates()
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
            var request = new GetRatesRequest(userId);
            var rates = await mediator.Send(request);
            return Ok(rates!);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}

