
using Domain;
using MediatR;

namespace Application.ExchangeRequests;

public sealed record ExchangeRequestCommand : IRequest
{
    public int UserId { get; set; }
    public string CryptocurrencyAbbreviationFirst { get; set; }
    public double ExchangeAmountFirst { get; set; }
    public string CryptocurrencyAbbreviationSecond { get; set; }
    public double ExchangeAmountSecond { get; set; }

    public ExchangeRequestCommand(int userId, string cryptocurrencyAbbreviationFirst, double exchangeAmountFirst, string cryptocurrencyAbbreviationSecond, double exchangeAmountSecond)
    {
        UserId = userId;
        CryptocurrencyAbbreviationFirst = cryptocurrencyAbbreviationFirst;
        ExchangeAmountFirst = exchangeAmountFirst;
        CryptocurrencyAbbreviationSecond = cryptocurrencyAbbreviationSecond;
        ExchangeAmountSecond = exchangeAmountSecond;
    }
}

public sealed record ExchangeRequest : IRequest<Exchange>
{
    public string CryptocurrencyAbbreviationFirst { get; set; }
    public double ExchangeAmountFirst { get; set; }
    public string CryptocurrencyAbbreviationSecond { get; set; }
    public double ExchangeAmountSecond { get; set; }
}
