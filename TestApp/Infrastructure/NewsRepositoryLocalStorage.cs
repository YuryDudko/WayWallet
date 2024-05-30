

using Domain;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure;

public class NewsRepositoryLocalStorage : INewsRepository
{
    private readonly AppDbContext _context;

    public NewsRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddNewsAsync(News news)
    {
        _context.News.Add(news);
        await _context.SaveChangesAsync();
    }

    public async Task AcceptNewsAsync(int NewsId)
    {
        var news = await _context.News.FirstOrDefaultAsync(n => n.Id == NewsId);
        if (news != null)
        {
            news.OnModeration = false;
            await _context.SaveChangesAsync();
        }
    }

    public async Task<IEnumerable<News>> GetAllNewsAsync()
    {
        return await _context.News.ToListAsync();
    }

    public async Task<News> GetNewsByIdAsync(int id)
    {
        return await _context.News.FirstOrDefaultAsync(n => n.Id == id);
    }

    public async Task<IEnumerable<News>> GetNewsOnModerationAsync()
    {
        return await _context.News.Where(n => n.OnModeration).ToListAsync();
    }

    public async Task<IEnumerable<News>> GetNewsNotOnModerationAsync()
    {
        return await _context.News.Where(n => !n.OnModeration).ToListAsync();
    }
}

