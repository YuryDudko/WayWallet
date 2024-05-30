

namespace Domain;

public class Exchange
{
    public int UserId { get; set; }
    public string ExchangeName { get; set; }
    public int Id { get; set; }
    public string CryptocurrencyAbbreviationFirst { get; set; }
    public double ExchangeAmountFirst { get; set; }
    public string CryptocurrencyAbbreviationSecond { get; set; }
    public double ExchangeAmountSecond { get; set; }
    public DateTime ExchangeDate { get; set; }
}

