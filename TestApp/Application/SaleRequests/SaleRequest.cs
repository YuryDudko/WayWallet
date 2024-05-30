

using Domain;
using MediatR;

namespace Application.SaleRequests;

public sealed record SaleRequestCommand : IRequest
{
    public int UserId { get; set; }
    public double SaleRateValue { get; set; }
    public double OrderAmount { get; set; }
    public String SenderAdress { get; set; }
    public String CryptoAbbreviation { get; set; }

    public SaleRequestCommand(int userId, double saleRateValue, double orderAmount, String senderAdress, String cryptoAbbreviation)
    {
        UserId = userId;
        SaleRateValue = saleRateValue;
        OrderAmount = orderAmount;
        SenderAdress = senderAdress;
        CryptoAbbreviation = cryptoAbbreviation;
    }
}
public sealed record SaleRequest : IRequest<Sale>
{
    public double SaleRateValue { get; set; }
    public double OrderAmount { get; set; }
    public String SenderAdress { get; set; }
    public String CryptoAbbreviation { get; set; }
}
