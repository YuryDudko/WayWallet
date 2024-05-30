

namespace Domain;

public class Transfer
{
    public int Id { get; set; }
    public string Name { get; set; }
    public DateTime DateTime { get; set; }
    public String SenderAdress { get; set; }
    public String ClaimerAdress { get; set; }
    public double TransferAmount { get; set; }
    public String CryptoAbbreviation { get; set; }
}
