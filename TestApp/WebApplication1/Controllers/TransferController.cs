using Application.TransferRequests;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class TransferController(IMediator mediator) : Controller
{

    [HttpPost("/Transfer")]
    public async Task<IActionResult> Transfer([FromBody] TransferCryptoRequest request)
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

            var command = new TransferCryptoCommand(userId, request.RecipientAddress, request.Currency, request.Network, request.Amount);
            await mediator.Send(command);
            return Ok("Transfer successful.");
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
