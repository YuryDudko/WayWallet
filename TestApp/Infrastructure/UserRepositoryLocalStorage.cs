using Domain;

namespace Infrastructure;

public class UserRepositoryLocalStorage : IUserRepository
{
    private readonly List<User> _users = new List<User>();
    public Task AddUserAsync(User user)
    {
        _users.Add(user);
        return Task.CompletedTask;
    }

    public Task RemoveUserAsync(User user)
    {
        _users.Remove(user);
        return Task.CompletedTask;
    }

    public User GetUserByUsernameAndPassword(string username, string password)
    {
        return _users.FirstOrDefault(u => u.Username == username && u.Password == password);
    }

    public User GetUserByEmailAndPassword(string email, string password)
    {
        return _users.FirstOrDefault(u =>u.Email == email && u.Password == password);
    }

    public User GetUserById(int id)
    {
        return _users.Find(u => u.Id == id);
    }
}
