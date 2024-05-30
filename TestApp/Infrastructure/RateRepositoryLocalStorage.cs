using Domain;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System.Globalization;
using System.Net.Http;

namespace Infrastructure;

public class RateRepositoryLocalStorage : IRateRepository
{
    private readonly AppDbContext _context;
    private readonly HttpClient _httpClient;

    public RateRepositoryLocalStorage(AppDbContext context , HttpClient httpClient)
    {
        _context = context;
        _httpClient = httpClient;
    }

    public async Task<IEnumerable<Rate>> GetAllRatesAsync()
    {
        return await _context.Rates.ToListAsync();
    }

    public async Task<Rate> GetRateByIdAsync(int? id)
    {
        return await _context.Rates.FirstOrDefaultAsync(r => r.Id == id);
    }

    public async Task UpdateRatesAsync(List<Rate> rates)
    {
        _context.Rates.UpdateRange(rates);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateRatesFromApiAsync()
    {
        var response = await _httpClient.GetStringAsync("https://api.coinlore.net/api/tickers/");
        var apiResponse = JsonConvert.DeserializeObject<ApiResponse>(response);

        if (apiResponse != null && apiResponse.Data != null)
        {
            var existingRates = await _context.Rates.ToListAsync();

            foreach (var coin in apiResponse.Data)
            {
                var existingRate = existingRates.FirstOrDefault(r => r.CoinId == int.Parse(coin.Id));
                if (existingRate != null)
                {
                    existingRate.Symbol = coin.Symbol;
                    existingRate.Name = coin.Name;
                    existingRate.Rank = coin.Rank;
                    existingRate.PriceUsd = coin.price_usd;
                    existingRate.PercentChange24h = coin.percent_change_24h;
                    existingRate.PercentChange1h = coin.percent_change_1h;
                    existingRate.PercentChange7d = coin.percent_change_7d;
                    existingRate.PriceBtc = coin.price_btc;
                }
                else
                {
                    // Если запись не существует, создаем новую запись
                    var newRate = new Rate
                    {
                        CoinId = int.Parse(coin.Id),
                        Symbol = coin.Symbol,
                        Name = coin.Name,
                        Rank = coin.Rank,
                        PriceUsd = coin.price_usd,
                        PercentChange24h = coin.percent_change_24h,
                        PercentChange1h = coin.percent_change_1h,
                        PercentChange7d = coin.percent_change_7d,
                        PriceBtc = coin.price_btc
                    };
                    _context.Rates.Add(newRate);
                }
            }

            // Сохранение изменений в базе данных
            await _context.SaveChangesAsync();
        }
    }

}

public class CoinData
{
    public string Id { get; set; }
    public string Symbol { get; set; }
    public string Name { get; set; }
    public int Rank { get; set; }
    public double price_usd { get; set; }
    public double percent_change_24h { get; set; }
    public double percent_change_1h { get; set; }
    public double percent_change_7d { get; set; }
    public double price_btc { get; set; }
}

public class ApiResponse
{
    public List<CoinData> Data { get; set; }
    public ApiInfo Info { get; set; }
}

public class ApiInfo
{
    public int CoinsNum { get; set; }
    public long Time { get; set; }
}

