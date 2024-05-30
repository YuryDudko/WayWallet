using Domain;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure;

public class UserRepositoryLocalStorage : IUserRepository
{
    private readonly AppDbContext _context;

    public UserRepositoryLocalStorage(AppDbContext context)
    {
        _context = context;
    }
    public async Task AddUserAsync(User user)
    {
        _context.Users.Add(user);
        await _context.SaveChangesAsync();
    }

    public async Task RemoveUserAsync(User user)
    {
        _context.Users.Remove(user);
        await _context.SaveChangesAsync();
    }

    public async Task<User> GetUserByUsernameAndPasswordAsync(string username, string password)
    {
        return await _context.Users.FirstOrDefaultAsync(u => u.Username == username && u.Password == password);
    }

    public async Task<User> GetUserByEmailAndPasswordAsync(string email, string password)
    {
        return await _context.Users.FirstOrDefaultAsync(u => u.Email == email && u.Password == password);
    }


    public User GetUserById(int id)
    {
        return _context.Users.Find(id);
    }
    public User GetUserByName(string  name)
    {
        return _context.Users.FirstOrDefault(u => u.Username == name);
    }

    public async Task<User> GetUserByIdAsync(int id) // Асинхронный метод
    {
        return await _context.Users.FindAsync(id);
    }
}
