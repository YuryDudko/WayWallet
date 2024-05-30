using Application.GetTransactionHistoryRequests;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class TransactionHistoryController(IMediator mediator) : Controller
{
    [HttpGet("/GetTransactionHistory")]
    public async Task<IActionResult> GetTransactionHistory()
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

            var request = new GetTransactionHistoryRequest(userId);
            var history = await mediator.Send(request);
            return Ok(history);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
