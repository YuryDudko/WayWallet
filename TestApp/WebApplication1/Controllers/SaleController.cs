using Application.SaleRequests;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using MediatR;

namespace WebApplication1.Controllers;

[Authorize]
public class SaleController(IMediator mediator) : Controller
{
    [HttpPost("/Sale")]
    public async Task<IActionResult> Sale([FromBody] SaleRequest request)
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

            var command = new SaleRequestCommand(userId, request.SaleRateValue, request.OrderAmount, request.SenderAdress, request.CryptoAbbreviation);
            await mediator.Send(command);
            return Ok("Sale successful.");
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
