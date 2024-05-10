using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class RelationsFixNew : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CryptoCurrencies_Rates_RateId",
                table: "CryptoCurrencies");

            migrationBuilder.DropForeignKey(
                name: "FK_CryptoCurrencies_Wallets_WalletId",
                table: "CryptoCurrencies");

            migrationBuilder.AlterColumn<int>(
                name: "WalletId",
                table: "CryptoCurrencies",
                type: "INTEGER",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.AlterColumn<int>(
                name: "RateId",
                table: "CryptoCurrencies",
                type: "INTEGER",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.AddForeignKey(
                name: "FK_CryptoCurrencies_Rates_RateId",
                table: "CryptoCurrencies",
                column: "RateId",
                principalTable: "Rates",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_CryptoCurrencies_Wallets_WalletId",
                table: "CryptoCurrencies",
                column: "WalletId",
                principalTable: "Wallets",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CryptoCurrencies_Rates_RateId",
                table: "CryptoCurrencies");

            migrationBuilder.DropForeignKey(
                name: "FK_CryptoCurrencies_Wallets_WalletId",
                table: "CryptoCurrencies");

            migrationBuilder.AlterColumn<int>(
                name: "WalletId",
                table: "CryptoCurrencies",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "INTEGER",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "RateId",
                table: "CryptoCurrencies",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "INTEGER",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_CryptoCurrencies_Rates_RateId",
                table: "CryptoCurrencies",
                column: "RateId",
                principalTable: "Rates",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CryptoCurrencies_Wallets_WalletId",
                table: "CryptoCurrencies",
                column: "WalletId",
                principalTable: "Wallets",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
