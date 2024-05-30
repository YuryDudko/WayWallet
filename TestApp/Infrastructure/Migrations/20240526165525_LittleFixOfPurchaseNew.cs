using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class LittleFixOfPurchaseNew : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Purchases_FinanceSystems_FinanceSystemId",
                table: "Purchases");

            migrationBuilder.AlterColumn<int>(
                name: "FinanceSystemId",
                table: "Purchases",
                type: "INTEGER",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.AddForeignKey(
                name: "FK_Purchases_FinanceSystems_FinanceSystemId",
                table: "Purchases",
                column: "FinanceSystemId",
                principalTable: "FinanceSystems",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Purchases_FinanceSystems_FinanceSystemId",
                table: "Purchases");

            migrationBuilder.AlterColumn<int>(
                name: "FinanceSystemId",
                table: "Purchases",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "INTEGER",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Purchases_FinanceSystems_FinanceSystemId",
                table: "Purchases",
                column: "FinanceSystemId",
                principalTable: "FinanceSystems",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
