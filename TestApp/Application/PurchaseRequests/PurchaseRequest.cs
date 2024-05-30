using Domain;
using MediatR;

namespace Application.PurchaseRequests;

public sealed record PurchaseRequestCommand : IRequest
{
    public int UserId { get; set; }
    public double PurchaseRateValue { get; set; }
    public double OrderAmount { get; set; }
    public String ReceiverAdress { get; set; }
    public String CryptoAbbreviation { get; set; }

    public PurchaseRequestCommand(int userId, double purchaseRateValue , double orderAmount , String receiverAdress, String cryptoAbbreviation)
    {
        UserId = userId;
        PurchaseRateValue = purchaseRateValue;
        OrderAmount = orderAmount;
        ReceiverAdress = receiverAdress;
        CryptoAbbreviation = cryptoAbbreviation;
    }
}
public sealed record PurchaseRequest : IRequest<Purchase>
{
    public double PurchaseRateValue { get; set; }
    public double OrderAmount { get; set; }
    public String ReceiverAdress { get; set; }
    public String CryptoAbbreviation { get; set; }
}
