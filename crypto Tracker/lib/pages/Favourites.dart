import 'package:amazonclone/models/cryptocurrency.dart';
import 'package:amazonclone/providers/market_provider.dart';
import 'package:amazonclone/widgets/cryptolisttile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<Cryptocurrency> favourites = marketProvider.markets
            .where((element) => element.isFavourite == true)
            .toList();

        if (favourites.length > 0) {
          return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              Cryptocurrency currentCrypto = favourites[index];

              return CryptoListTile(currentCrypto: currentCrypto);
            },
          );
        } else {
          return const Center(
            child: Text(
              "No Favourites yet",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          );
        }
      },
    );

    // return Container(
    //   child: const Text("Favourites will show here"),
    // );
  }
}
