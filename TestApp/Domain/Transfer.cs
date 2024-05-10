

namespace Domain;

public class Transfer
{
    public int Id { get; set; }
    public string Name { get; set; }
    public DateTime DateTime { get; set; }
    public Wallet Sender { get; set; }
    public Wallet Claimer { get; set; }
    public double TransferAmount { get; set; }
}
