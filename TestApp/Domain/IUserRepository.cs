namespace Domain;

public interface IUserRepository
{
    public Task AddUserAsync(User user);
    public Task RemoveUserAsync(User user);
    //public User GetUserByEmailAndPassword(string email, string password);
    public User GetUserById(int id);
    public User GetUserByName(string name);
    public Task<User> GetUserByUsernameAndPasswordAsync(string username, string password);
    public Task<User> GetUserByEmailAndPasswordAsync(string email, string password);
    public Task<User> GetUserByIdAsync(int id);


}
