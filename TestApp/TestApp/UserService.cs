using Microsoft.AspNetCore.Mvc;
using System.Web.Http;

namespace TestApp
{
    public class UserService
    {
        private List<User> _users;

        public UserService()
        {
            _users = new List<User>();
        }

        public void CreateUser(User user)
        {
            _users.Add(user);
        }

        public User GetUserByUsername(string username)
        {
            return _users.FirstOrDefault(u => u.Username == username);
        }

        public User GetUserByUsernameAndPassword(string username, string password)
        {
            return _users.FirstOrDefault(u => u.Username == username && u.Password == password);
        }
        

    }
}
