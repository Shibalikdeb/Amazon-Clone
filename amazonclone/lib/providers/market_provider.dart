import 'dart:async';

import 'package:amazonclone/models/API.dart';
import 'package:amazonclone/models/cryptocurrency.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<Cryptocurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API().getMarkets();

    List<Cryptocurrency> temp = [];
    for (var market in _markets) {
      Cryptocurrency newCrypto = Cryptocurrency.fromJSON(market);
      temp.add(newCrypto);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      fetchData();
      print("Data Updated");
    });
  }

  Cryptocurrency fetchCryptoById(String id) {
    Cryptocurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }
}
