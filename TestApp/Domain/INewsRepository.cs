namespace Domain;

public interface INewsRepository
{
    Task AddNewsAsync(News news);
    Task AcceptNewsAsync(int NewsId);
    Task<IEnumerable<News>> GetAllNewsAsync();
    Task<News> GetNewsByIdAsync(int id);
    Task<IEnumerable<News>> GetNewsOnModerationAsync(); // Новости на модерации
    Task<IEnumerable<News>> GetNewsNotOnModerationAsync(); // Новости не на модерации
}

