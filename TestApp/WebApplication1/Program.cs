using Application.RegistrationRequests;
using Application.LoginRequests;
using Application.WalletAdditionRequests;
using Infrastructure;
namespace WebApplication1
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();

            // Добавление сервиса для поддержки аутентификации
            builder.Services.AddAuthentication("Bearer")
                .AddJwtBearer(options =>
                {
                    options.Authority = "http://0.0.0.0:80";
                    options.RequireHttpsMetadata = false;
                    options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
                    {
                        ValidateAudience = false
                    };
                });
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll",
                    builder =>
                    {
                        builder
                                .AllowAnyOrigin()
                                .AllowAnyMethod()
                                .AllowAnyHeader();
                    });
            });
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            //builder.Services.AddSwaggerGen();

            builder.Services.AddHandler();
            builder.Services.AddRepositories();
            builder.Services.AddLoginHandler();
            builder.Services.AddWalletAdditionHandler();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                /*app.UseSwagger();
                app.UseSwaggerUI();*/
            }

            app.UseHttpsRedirection();

            app.UseCors("AllowAll");

            app.UseAuthorization();

            

            app.UseAuthentication();

            app.Urls.Add("http://0.0.0.0:80");

            

            app.MapControllers();

            app.Run();
        }
    }
}
