

namespace Domain;

public class News
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public DateTime CreatedAt { get; set; }
    public bool OnModeration { get; set; }
    public int UserId { get; set; }
}