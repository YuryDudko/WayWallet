using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace TestApp
{
    [Route("api/auth/")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly UserService _userService;

        public AuthController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost("register")]
        public IActionResult Register([FromBody] User user)
        {
            if (user == null || string.IsNullOrEmpty(user.Username) || string.IsNullOrEmpty(user.Password))
            {
                return BadRequest("Invalid user data");
            }

            if (user.Username.ToLower() == "admin")
            {
                user.Role = UserRole.Admin;
            }
            else
            {
                user.Role = UserRole.CommonUser;
            }

            _userService.CreateUser(user);

            //var result = await _userManager.CreateAsync(user, user.Password);
            //if (!result.Succeeded)
            //{
            //    return BadRequest("Failed to register user");
            //}

            //if (user.UserName.ToLower() == "admin")
            //{
            //    await _userManager.AddToRoleAsync(user, "Admin");
            //}
            return Ok("Sucessfull registration");
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] User user)
        {
            if (user == null || string.IsNullOrEmpty(user.Username) || string.IsNullOrEmpty(user.Password))
            {
                return BadRequest("Invalid user data");
            }

            //// Аутентификация пользователя
            //var result = await _signInManager.PasswordSignInAsync(user.UserName, user.Password, false, lockoutOnFailure: false);
            //if (!result.Succeeded)
            //{
            //    return Unauthorized("Failed to login");
            //}

            //// Проверка роли при входе
            //var appUser = await _userManager.FindByNameAsync(user.UserName);
            //if (await _userManager.IsInRoleAsync(appUser, "Admin"))
            //{
            //    //Admin role
            //}
            //else
            //{
            //    //Usual user
            //}
            //UserRole role = user.Username.ToLower() == "admin" ? UserRole.Admin : UserRole.CommonUser;


            var existingUser = _userService.GetUserByUsernameAndPassword(user.Username, user.Password);
            if (existingUser == null)
            {
                return Unauthorized();
            }

            if (existingUser.Username.ToLower() == "admin" && existingUser.Role == UserRole.Admin)
            {
                    return Ok("Admin login successful");
            }
            else
            {
                return Ok("Common user login successful");
            }
        }

        //[Authorize(Policy = "RequireAdminRole")]
        //[HttpPost("ban")]
        //public IActionResult Ban([FromBody] User user , User admin)
        //{
        //    if (user == null || string.IsNullOrEmpty(user.Username) || string.IsNullOrEmpty(user.Password))
        //    {
        //        return BadRequest("Invalid user data");
        //    }

        //    var AdminUser = _userService.GetUserByUsernameAndPassword(admin.Username, admin.Password);
        //    var BanUser = _userService.GetUserByUsernameAndPassword(user.Username, user.Password);
        //    if (AdminUser == null || BanUser == null)
        //    {
        //        return Unauthorized("There is no such registered user");
        //    }
        //    if(AdminUser.Role != UserRole.Admin)
        //    {
        //        return BadRequest("You have no admin role to access this");
        //    }
        //    else if(AdminUser.Role == UserRole.Admin && BanUser.Role == UserRole.CommonUser)
        //    {
        //        BanUser.Role = UserRole.EmptyUser;
        //    }
            
        //    return Ok();

        //}
    }

}
