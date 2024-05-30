using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class FinanceSystem_Buy_Sale : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CryptocurrencyAbbreviation",
                table: "Rates",
                type: "TEXT",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "FinanceSystemId",
                table: "Rates",
                type: "INTEGER",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "FinanceSystems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Name = table.Column<string>(type: "TEXT", nullable: false),
                    Balance = table.Column<double>(type: "REAL", nullable: false),
                    TransactionFee = table.Column<double>(type: "REAL", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinanceSystems", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Purchases",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Name = table.Column<string>(type: "TEXT", nullable: false),
                    PurchaseRateValue = table.Column<double>(type: "REAL", nullable: false),
                    OrderAmount = table.Column<double>(type: "REAL", nullable: false),
                    OrderDate = table.Column<DateTime>(type: "TEXT", nullable: false),
                    ReceiverAdress = table.Column<string>(type: "TEXT", nullable: false),
                    PurchaseAmount = table.Column<double>(type: "REAL", nullable: false),
                    CryptoAbbreviation = table.Column<string>(type: "TEXT", nullable: false),
                    FinanceSystemId = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Purchases", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Purchases_FinanceSystems_FinanceSystemId",
                        column: x => x.FinanceSystemId,
                        principalTable: "FinanceSystems",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Sales",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Name = table.Column<string>(type: "TEXT", nullable: false),
                    SaleRateId = table.Column<int>(type: "INTEGER", nullable: false),
                    OrderAmount = table.Column<double>(type: "REAL", nullable: false),
                    OrderDate = table.Column<DateTime>(type: "TEXT", nullable: false),
                    senderAdress = table.Column<string>(type: "TEXT", nullable: false),
                    SaleAmount = table.Column<double>(type: "REAL", nullable: false),
                    CryptoAbbreviation = table.Column<string>(type: "TEXT", nullable: false),
                    FinanceSystemId = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Sales", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Sales_FinanceSystems_FinanceSystemId",
                        column: x => x.FinanceSystemId,
                        principalTable: "FinanceSystems",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Sales_Rates_SaleRateId",
                        column: x => x.SaleRateId,
                        principalTable: "Rates",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Rates_FinanceSystemId",
                table: "Rates",
                column: "FinanceSystemId");

            migrationBuilder.CreateIndex(
                name: "IX_Purchases_FinanceSystemId",
                table: "Purchases",
                column: "FinanceSystemId");

            migrationBuilder.CreateIndex(
                name: "IX_Sales_FinanceSystemId",
                table: "Sales",
                column: "FinanceSystemId");

            migrationBuilder.CreateIndex(
                name: "IX_Sales_SaleRateId",
                table: "Sales",
                column: "SaleRateId");

            migrationBuilder.AddForeignKey(
                name: "FK_Rates_FinanceSystems_FinanceSystemId",
                table: "Rates",
                column: "FinanceSystemId",
                principalTable: "FinanceSystems",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Rates_FinanceSystems_FinanceSystemId",
                table: "Rates");

            migrationBuilder.DropTable(
                name: "Purchases");

            migrationBuilder.DropTable(
                name: "Sales");

            migrationBuilder.DropTable(
                name: "FinanceSystems");

            migrationBuilder.DropIndex(
                name: "IX_Rates_FinanceSystemId",
                table: "Rates");

            migrationBuilder.DropColumn(
                name: "CryptocurrencyAbbreviation",
                table: "Rates");

            migrationBuilder.DropColumn(
                name: "FinanceSystemId",
                table: "Rates");
        }
    }
}
