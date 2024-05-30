
namespace Domain;

public class Rate
{
    public int Id { get; set; }
    public int CoinId { get; set; }  // ID монеты в системе CoinLore
    public string Symbol { get; set; }
    public string Name { get; set; }
    public int Rank { get; set; }
    public double PriceUsd { get; set; }
    public double PercentChange24h { get; set; }
    public double PercentChange1h { get; set; }
    public double PercentChange7d { get; set; }
    public double PriceBtc { get; set; }
}
