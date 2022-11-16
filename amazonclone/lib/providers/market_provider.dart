import 'package:amazonclone/models/API.dart';
import 'package:amazonclone/models/cryptocurrency.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<Cryptocurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  void fetchData() async {
    List<dynamic> _markets = await API.getMarkets();

    List<Cryptocurrency> temp = [];
    for (var market in _markets) {
      Cryptocurrency newCrypto = Cryptocurrency.fromJSON(market);
      temp.add(newCrypto);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();
  }
}
