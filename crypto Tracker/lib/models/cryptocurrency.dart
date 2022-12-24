class Cryptocurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketcap;
  int? marketcaprank;
  double? high24;
  double? low24;
  double? priceChange24;
  double? pricechangepercentage24;
  double? circulatingsupply;
  double? ath;
  double? atl;
  bool isFavourite = false;

  Cryptocurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentPrice,
      required this.marketcap,
      required this.marketcaprank,
      required this.high24,
      required this.low24,
      required this.priceChange24,
      required this.pricechangepercentage24,
      required this.circulatingsupply,
      required this.ath,
      required this.atl});
  factory Cryptocurrency.fromJSON(Map<String, dynamic> map) {
    return Cryptocurrency(
        id: map["id"],
        symbol: map["symbol"],
        name: map["name"],
        image: map["image"],
        currentPrice: double.parse(map["current_price"].toString()),
        marketcap: double.parse(map["market_cap"].toString()),
        marketcaprank: map["market_cap_rank"],
        high24: double.parse(map["high_24h"].toString()),
        low24: double.parse(map["low_24h"].toString()),
        priceChange24: double.parse(map["price_change_24h"].toString()),
        pricechangepercentage24:
            double.parse(map["price_change_percentage_24h"].toString()),
        circulatingsupply: double.parse(map["circulating_supply"].toString()),
        ath: double.parse(map["ath"].toString()),
        atl: double.parse(map["atl"].toString()));
  }
}
