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
    [Migration("20240510000553_Fix")]
    partial class Fix
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "8.0.4");

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

            modelBuilder.Entity("Domain.Rate", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<double>("ActualValue")
                        .HasColumnType("REAL");

                    b.Property<double>("LastValue")
                        .HasColumnType("REAL");

                    b.Property<double>("ValuesSpread")
                        .HasColumnType("REAL");

                    b.HasKey("Id");

                    b.ToTable("Rates");
                });

            modelBuilder.Entity("Domain.Transfer", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<int>("ClaimerId")
                        .HasColumnType("INTEGER");

                    b.Property<DateTime>("DateTime")
                        .HasColumnType("TEXT");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int>("SenderId")
                        .HasColumnType("INTEGER");

                    b.Property<double>("TransferAmount")
                        .HasColumnType("REAL");

                    b.HasKey("Id");

                    b.HasIndex("ClaimerId");

                    b.HasIndex("SenderId");

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

                    b.HasOne("Domain.Wallet", "Wallet")
                        .WithMany("CryptoCurrencies")
                        .HasForeignKey("WalletId");

                    b.Navigation("Rate");

                    b.Navigation("Wallet");
                });

            modelBuilder.Entity("Domain.Transfer", b =>
                {
                    b.HasOne("Domain.Wallet", "Claimer")
                        .WithMany()
                        .HasForeignKey("ClaimerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Domain.Wallet", "Sender")
                        .WithMany()
                        .HasForeignKey("SenderId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Claimer");

                    b.Navigation("Sender");
                });

            modelBuilder.Entity("Domain.Wallet", b =>
                {
                    b.HasOne("Domain.User", "User")
                        .WithMany("Wallets")
                        .HasForeignKey("UserId");

                    b.Navigation("User");
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
