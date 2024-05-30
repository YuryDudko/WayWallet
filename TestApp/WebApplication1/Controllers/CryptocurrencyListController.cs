using Application.GetCryptoListRequests;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class CryptocurrencyListController (IMediator mediator) : Controller
{
    [HttpGet("/GetCryptocurrencyList")]
    public async Task<IActionResult> CryptoListGet()
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
            var request = new GetCryptoListRequest(userId);
            var res = await mediator.Send(request);
            return Ok(res!);
        }
        catch (NullCryptoListException ex)
        {
            return NotFound(ex.Message);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
