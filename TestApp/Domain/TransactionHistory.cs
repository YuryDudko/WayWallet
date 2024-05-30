namespace Domain;

public class TransactionHistory
{
    public int Id { get; set; }
    public string TransactionType { get; set; }
    public DateTime TransactionDate { get; set; }
    public string CryptoAbbreviation { get; set; }
    public double Amount { get; set; }
    public string Address { get; set; }
    public double EquivalentAmount { get; set; }
}

