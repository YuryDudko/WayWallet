using Microsoft.AspNetCore.Identity;

namespace TestApp;

public enum UserRole
{
    CommonUser,
    Admin,
    EmptyUser
}
public class User
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }
    public UserRole Role { get; set; }
}
