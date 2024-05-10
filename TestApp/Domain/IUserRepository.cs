namespace Domain;

public interface IUserRepository
{
    public Task AddUserAsync(User user);
    public Task RemoveUserAsync(User user);
    public User GetUserByUsernameAndPassword(string username, string password);
    public User GetUserByEmailAndPassword(string email, string password);
    public User GetUserById(int id);
    public User GetUserByName(string name);


}
