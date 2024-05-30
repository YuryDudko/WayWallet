

namespace Domain;

public class FinanceSystem
{
    public int Id { get; set; }
    public string Name { get; set; }
    public double Balance { get; set; }
    public double TransactionFee { get; set; }
    public List<Rate> Rates { get; set; } = new();
    public List<Purchase> Purchases { get; set; } = new();
    public List<Sale> Sales { get; set; } = new();
}
