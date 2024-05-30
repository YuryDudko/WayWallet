using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class RatesUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "ValuesSpread",
                table: "Rates",
                newName: "PriceUsd");

            migrationBuilder.RenameColumn(
                name: "LastValue",
                table: "Rates",
                newName: "PriceBtc");

            migrationBuilder.RenameColumn(
                name: "CryptocurrencyAbbreviation",
                table: "Rates",
                newName: "Symbol");

            migrationBuilder.RenameColumn(
                name: "ActualValue",
                table: "Rates",
                newName: "PercentChange7d");

            migrationBuilder.AddColumn<int>(
                name: "CoinId",
                table: "Rates",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "Rates",
                type: "TEXT",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<double>(
                name: "PercentChange1h",
                table: "Rates",
                type: "REAL",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "PercentChange24h",
                table: "Rates",
                type: "REAL",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<int>(
                name: "Rank",
                table: "Rates",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CoinId",
                table: "Rates");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "Rates");

            migrationBuilder.DropColumn(
                name: "PercentChange1h",
                table: "Rates");

            migrationBuilder.DropColumn(
                name: "PercentChange24h",
                table: "Rates");

            migrationBuilder.DropColumn(
                name: "Rank",
                table: "Rates");

            migrationBuilder.RenameColumn(
                name: "Symbol",
                table: "Rates",
                newName: "CryptocurrencyAbbreviation");

            migrationBuilder.RenameColumn(
                name: "PriceUsd",
                table: "Rates",
                newName: "ValuesSpread");

            migrationBuilder.RenameColumn(
                name: "PriceBtc",
                table: "Rates",
                newName: "LastValue");

            migrationBuilder.RenameColumn(
                name: "PercentChange7d",
                table: "Rates",
                newName: "ActualValue");
        }
    }
}
