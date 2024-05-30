using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class ExchangeAddition : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Exchanges",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    UserId = table.Column<int>(type: "INTEGER", nullable: false),
                    ExchangeName = table.Column<string>(type: "TEXT", nullable: false),
                    CryptocurrencyAbbreviationFirst = table.Column<string>(type: "TEXT", nullable: false),
                    ExchangeAmountFirst = table.Column<double>(type: "REAL", nullable: false),
                    CryptocurrencyAbbreviationSecond = table.Column<string>(type: "TEXT", nullable: false),
                    ExchangeAmountSecond = table.Column<double>(type: "REAL", nullable: false),
                    ExchangeDate = table.Column<DateTime>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Exchanges", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Exchanges");
        }
    }
}
