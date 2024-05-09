using Application.WalletAdditionRequests;
using Domain;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace WebApplication1.Controllers;

public class WalletAdditionController (IMediator mediator) : Controller
{
    [HttpPost("/AddWallet")]
    public async Task<IActionResult> Walletaddition([FromBody] WalletAdditionRequest walletAdditionRequest)
    {
        int? userId = Request.HttpContext.GetUserId();
        walletAdditionRequest.UserId = (userId is not null) ? (int)userId : walletAdditionRequest.UserId;

        try
        {
            var res = await mediator.Send(walletAdditionRequest);
            return Ok(res!);
        }
        catch (NullWalletException ex)
        {
            return NotFound(ex.Message);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
