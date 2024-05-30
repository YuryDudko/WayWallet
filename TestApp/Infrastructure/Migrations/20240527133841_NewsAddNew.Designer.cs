﻿// <auto-generated />
using System;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace Infrastructure.Migrations
{
    [DbContext(typeof(AppDbContext))]
    [Migration("20240527133841_NewsAddNew")]
    partial class NewsAddNew
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "8.0.5");

            modelBuilder.Entity("Domain.CryptoCurrency", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("CurrencyAdress")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<double>("CurrencyAmount")
                        .HasColumnType("REAL");

                    b.Property<string>("CurrencyCode")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("CurrencyName")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int?>("RateId")
                        .HasColumnType("INTEGER");

                    b.Property<int?>("WalletId")
                        .HasColumnType("INTEGER");

                    b.HasKey("Id");

                    b.HasIndex("RateId");

                    b.HasIndex("WalletId");

                    b.ToTable("CryptoCurrencies");
                });

            modelBuilder.Entity("Domain.FinanceSystem", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<double>("Balance")
                        .HasColumnType("REAL");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<double>("TransactionFee")
                        .HasColumnType("REAL");

                    b.HasKey("Id");

                    b.ToTable("FinanceSystems");
                });

            modelBuilder.Entity("Domain.News", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("TEXT");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int>("UserId")
                        .HasColumnType("INTEGER");

                    b.HasKey("Id");

                    b.ToTable("News");
                });

            modelBuilder.Entity("Domain.Purchase", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("CryptoAbbreviation")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int?>("FinanceSystemId")
                        .HasColumnType("INTEGER");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<double>("OrderAmount")
                        .HasColumnType("REAL");

                    b.Property<DateTime>("OrderDate")
                        .HasColumnType("TEXT");

                    b.Property<double>("PurchaseAmount")
                        .HasColumnType("REAL");

                    b.Property<double>("PurchaseRateValue")
                        .HasColumnType("REAL");

                    b.Property<string>("ReceiverAdress")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.HasIndex("FinanceSystemId");

                    b.ToTable("Purchases");
                });

            modelBuilder.Entity("Domain.Rate", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<double>("ActualValue")
                        .HasColumnType("REAL");

                    b.Property<string>("CryptocurrencyAbbreviation")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int?>("FinanceSystemId")
                        .HasColumnType("INTEGER");

                    b.Property<double>("LastValue")
                        .HasColumnType("REAL");

                    b.Property<double>("ValuesSpread")
                        .HasColumnType("REAL");

                    b.HasKey("Id");

                    b.HasIndex("FinanceSystemId");

                    b.ToTable("Rates");
                });

            modelBuilder.Entity("Domain.Sale", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("CryptoAbbreviation")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int?>("FinanceSystemId")
                        .HasColumnType("INTEGER");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<double>("OrderAmount")
                        .HasColumnType("REAL");

                    b.Property<DateTime>("OrderDate")
                        .HasColumnType("TEXT");

                    b.Property<double>("SaleAmount")
                        .HasColumnType("REAL");

                    b.Property<double>("SaleRateValue")
                        .HasColumnType("REAL");

                    b.Property<string>("SenderAdress")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.HasIndex("FinanceSystemId");

                    b.ToTable("Sales");
                });

            modelBuilder.Entity("Domain.TransactionHistory", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("Address")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<double>("Amount")
                        .HasColumnType("REAL");

                    b.Property<string>("CryptoAbbreviation")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<double>("EquivalentAmount")
                        .HasColumnType("REAL");

                    b.Property<DateTime>("TransactionDate")
                        .HasColumnType("TEXT");

                    b.Property<string>("TransactionType")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.ToTable("TransactionHistorys");
                });

            modelBuilder.Entity("Domain.Transfer", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("ClaimerAdress")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("CryptoAbbreviation")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<DateTime>("DateTime")
                        .HasColumnType("TEXT");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("SenderAdress")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<double>("TransferAmount")
                        .HasColumnType("REAL");

                    b.HasKey("Id");

                    b.ToTable("Transfers");
                });

            modelBuilder.Entity("Domain.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int>("Role")
                        .HasColumnType("INTEGER");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("Domain.Wallet", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("KeyPhrase")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int?>("UserId")
                        .HasColumnType("INTEGER");

                    b.Property<double>("WalletBalance")
                        .HasColumnType("REAL");

                    b.Property<string>("WalletName")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Wallets");
                });

            modelBuilder.Entity("Domain.CryptoCurrency", b =>
                {
                    b.HasOne("Domain.Rate", "Rate")
                        .WithMany()
                        .HasForeignKey("RateId");

                    b.HasOne("Domain.Wallet", null)
                        .WithMany("CryptoCurrencies")
                        .HasForeignKey("WalletId");

                    b.Navigation("Rate");
                });

            modelBuilder.Entity("Domain.Purchase", b =>
                {
                    b.HasOne("Domain.FinanceSystem", "FinanceSystem")
                        .WithMany("Purchases")
                        .HasForeignKey("FinanceSystemId");

                    b.Navigation("FinanceSystem");
                });

            modelBuilder.Entity("Domain.Rate", b =>
                {
                    b.HasOne("Domain.FinanceSystem", null)
                        .WithMany("Rates")
                        .HasForeignKey("FinanceSystemId");
                });

            modelBuilder.Entity("Domain.Sale", b =>
                {
                    b.HasOne("Domain.FinanceSystem", "FinanceSystem")
                        .WithMany("Sales")
                        .HasForeignKey("FinanceSystemId");

                    b.Navigation("FinanceSystem");
                });

            modelBuilder.Entity("Domain.Wallet", b =>
                {
                    b.HasOne("Domain.User", null)
                        .WithMany("Wallets")
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("Domain.FinanceSystem", b =>
                {
                    b.Navigation("Purchases");

                    b.Navigation("Rates");

                    b.Navigation("Sales");
                });

            modelBuilder.Entity("Domain.User", b =>
                {
                    b.Navigation("Wallets");
                });

            modelBuilder.Entity("Domain.Wallet", b =>
                {
                    b.Navigation("CryptoCurrencies");
                });
#pragma warning restore 612, 618
        }
    }
}
