using Application.PurchaseRequests;
using Application.TransferRequests;
using Application.WalletAdditionRequests;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class PurchaseController(IMediator mediator) : Controller
{
    [HttpPost("/Purchase")]
    public async Task<IActionResult> Purchase([FromBody] PurchaseRequest request)
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

            var command = new PurchaseRequestCommand(userId, request.PurchaseRateValue, request.OrderAmount, request.ReceiverAdress, request.CryptoAbbreviation);
            await mediator.Send(command);
            return Ok("Purchase successful.");
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
