using Application.NewsRequests;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication1.Controllers;

[Authorize]
public class NewsController : Controller
{
    private readonly IMediator _mediator;

    public NewsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost("/CreateNews")]
    public async Task<IActionResult> CreateNews([FromBody] CreateNewsRequest request)
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

            var command = new CreateNewsCommand(userId, request.Title, request.Description);
            await _mediator.Send(command);
            return Ok("News created successfully.");
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpPost("/AcceptNews")]
    public async Task<IActionResult> AcceptNews([FromBody] AcceptNewsRequest request)
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

            var command = new AcceptNewsCommand(userId, request.NewsId);
            await _mediator.Send(command);
            return Ok("News accepted successfully.");
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }

    //[HttpGet("/GetNewsList")]
    //public async Task<IActionResult> GetNewsList()
    //{
    //    try
    //    {
    //        var newsList = await _mediator.Send(new GetNewsListQuery());
    //        return Ok(newsList);
    //    }
    //    catch (Exception ex)
    //    {
    //        return BadRequest(ex.Message);
    //    }
    //}

    [HttpGet("/GetNotModerationNews")]
    public async Task<IActionResult> GetNotModerationNews()
    {
        try
        {
            var newsList = await _mediator.Send(new GetNewsNotOnModerationQuery());
            return Ok(newsList);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpGet("/GetModerationNews")]
    public async Task<IActionResult> GetModerationNews()
    {
        try
        {
            var newsList = await _mediator.Send(new GetNewsOnModerationQuery());
            return Ok(newsList);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
