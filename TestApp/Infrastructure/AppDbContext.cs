using Domain;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure;

public class AppDbContext : DbContext
{
    public DbSet<User> Users { get; set; } = null!;
    public DbSet<Wallet> Wallets { get; set; } = null!;
    public DbSet<Rate> Rates { get; set; } = null!;
    public DbSet<CryptoCurrency> CryptoCurrencies { get; set; } = null!;
    public DbSet<Transfer> Transfers { get; set; } = null!;
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Wallet>()
        .HasMany(w => w.CryptoCurrencies); // У кошелька может быть много криптовалют
        //.WithOne(cc => cc.Wallet) // У каждой криптовалюты есть один кошелек
        // .HasForeignKey(cc => cc.WalletId); // Внешний ключ WalletId в криптовалюте

    }
}
