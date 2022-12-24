import 'package:amazonclone/models/cryptocurrency.dart';
import 'package:amazonclone/providers/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/detailspage.dart';

class CryptoListTile extends StatelessWidget {
  final Cryptocurrency currentCrypto;

  const CryptoListTile({super.key, required this.currentCrypto});

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(
                    id: currentCrypto.id!,
                  )),
        );
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(currentCrypto.name!, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 10),
          (currentCrypto.isFavourite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavourite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 18,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavourite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 18,
                  ),
                )
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
            style: const TextStyle(
              color: Color(0xff0395eb),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Builder(
            builder: (context) {
              double priceChange24 = currentCrypto.priceChange24!;
              double pricechangepercentage =
                  currentCrypto.pricechangepercentage24!;

              if (priceChange24 < 0) {
                return Text(
                  "${pricechangepercentage.toStringAsFixed(2)}% (${priceChange24.toStringAsFixed(4)})",
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                return Text(
                  "+${pricechangepercentage.toStringAsFixed(2)}% (${priceChange24.toStringAsFixed(4)})",
                  style: const TextStyle(color: Colors.green),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
