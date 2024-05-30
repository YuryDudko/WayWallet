using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Application.ExchangeRequests;

namespace WebApplication1.Controllers;

[Authorize]
public class ExchangeController : Controller
{
    private readonly IMediator _mediator;

    public ExchangeController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost("/Exchange")]
    public async Task<IActionResult> Exchange([FromBody] ExchangeRequest request)
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

            var command = new ExchangeRequestCommand(userId, request.CryptocurrencyAbbreviationFirst, request.ExchangeAmountFirst, request.CryptocurrencyAbbreviationSecond, request.ExchangeAmountSecond);
            await _mediator.Send(command);
            return Ok("Exchange successful.");
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}

