using Domain;
using MediatR;

namespace Application.NewsRequests;

public sealed record CreateNewsCommand(int UserId, string Title, string Description) : IRequest;

public class CreateNewsCommandHandler(INewsRepository newsRepository) : IRequestHandler<CreateNewsCommand>
{
    public async Task Handle(CreateNewsCommand request, CancellationToken cancellationToken)
    {
        var news = new News
        {
            Title = request.Title,
            Description = request.Description,
            CreatedAt = DateTime.UtcNow,
            UserId = request.UserId,
            OnModeration = true,
        };

        await newsRepository.AddNewsAsync(news);
        return;
    }
}

public sealed record AcceptNewsCommand(int UserId, int NewsId) : IRequest;

public class AcceptNewsCommandHandler(INewsRepository newsRepository) : IRequestHandler<AcceptNewsCommand>
{
    public async Task Handle(AcceptNewsCommand request, CancellationToken cancellationToken)
    {
        await newsRepository.AcceptNewsAsync(request.NewsId);
        return;
    }
}

//public class GetNewsListQuery : IRequest<IEnumerable<News>> { }

//public class GetNewsListQueryHandler(INewsRepository newsRepository) : IRequestHandler<GetNewsListQuery, IEnumerable<News>>
//{
//    public async Task<IEnumerable<News>> Handle(GetNewsListQuery request, CancellationToken cancellationToken)
//    {
//        return await newsRepository.GetAllNewsAsync();
//    }
//}

public sealed record GetNewsOnModerationQuery : IRequest<IEnumerable<News>> { }

public class GetNewsOnModerationQueryHandler(INewsRepository newsRepository) : IRequestHandler<GetNewsOnModerationQuery, IEnumerable<News>>
{
    public async Task<IEnumerable<News>> Handle(GetNewsOnModerationQuery request, CancellationToken cancellationToken)
    {
        return await newsRepository.GetNewsOnModerationAsync();
    }
}

public sealed record GetNewsNotOnModerationQuery : IRequest<IEnumerable<News>> { }

public class GetNewsNotOnModerationQueryHandler(INewsRepository newsRepository) : IRequestHandler<GetNewsNotOnModerationQuery, IEnumerable<News>>
{
    public async Task<IEnumerable<News>> Handle(GetNewsNotOnModerationQuery request, CancellationToken cancellationToken)
    {
        return await newsRepository.GetNewsNotOnModerationAsync();
    }
}



