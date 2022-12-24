import 'package:amazonclone/widgets/cryptolisttile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cryptocurrency.dart';
import '../providers/market_provider.dart';
import 'detailspage.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.markets.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: marketProvider.markets.length,
              itemBuilder: (context, index) {
                Cryptocurrency currentCrypto = marketProvider.markets[index];
                return CryptoListTile(currentCrypto: currentCrypto);
              },
            );
          } else {
            return const Text("Data Not Found!");
          }
        }
      },
    );
  }
}
