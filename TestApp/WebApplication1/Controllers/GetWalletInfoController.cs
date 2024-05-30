using Application.WalletInfoRequests;
using MediatR;
using Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class GetWalletInfoController(IMediator mediator) : Controller
{
    [HttpGet("/GetWalletInfo")]
    public async Task<IActionResult> GetWalletInfo()
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

            var request = new GetWalletInfoRequest(userId);
            var walletInfo = await mediator.Send(request);
            return Ok(walletInfo);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
