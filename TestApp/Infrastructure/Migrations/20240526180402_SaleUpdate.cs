using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class SaleUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Sales_Rates_SaleRateId",
                table: "Sales");

            migrationBuilder.DropIndex(
                name: "IX_Sales_SaleRateId",
                table: "Sales");

            migrationBuilder.DropColumn(
                name: "SaleRateId",
                table: "Sales");

            migrationBuilder.RenameColumn(
                name: "senderAdress",
                table: "Sales",
                newName: "SenderAdress");

            migrationBuilder.AddColumn<double>(
                name: "SaleRateValue",
                table: "Sales",
                type: "REAL",
                nullable: false,
                defaultValue: 0.0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "SaleRateValue",
                table: "Sales");

            migrationBuilder.RenameColumn(
                name: "SenderAdress",
                table: "Sales",
                newName: "senderAdress");

            migrationBuilder.AddColumn<int>(
                name: "SaleRateId",
                table: "Sales",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Sales_SaleRateId",
                table: "Sales",
                column: "SaleRateId");

            migrationBuilder.AddForeignKey(
                name: "FK_Sales_Rates_SaleRateId",
                table: "Sales",
                column: "SaleRateId",
                principalTable: "Rates",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
