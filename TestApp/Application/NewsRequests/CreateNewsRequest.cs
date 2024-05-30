

namespace Application.NewsRequests;

public class CreateNewsRequest
{
    public string Title { get; set; }
    public string Description { get; set; }
}

public class AcceptNewsRequest
{
    public int NewsId { get; set; }
}
