import 'package:amazonclone/models/cryptocurrency.dart';
import 'package:amazonclone/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleandDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          detail,
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Consumer<MarketProvider>(
              builder: (context, MarketProvider, child) {
            Cryptocurrency currentCrypto =
                MarketProvider.fetchCryptoById(widget.id);
            return ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(currentCrypto.image!),
                  ),
                  title: Text(
                    "${currentCrypto.name!}(${currentCrypto.symbol!.toUpperCase()})",
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    "₹${currentCrypto.currentPrice!.toStringAsFixed(4)}",
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: const Color(0xff0395eb),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Price change (24h)",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    double priceChange24 = currentCrypto.priceChange24!;
                    double pricechangepercentage =
                        currentCrypto.pricechangepercentage24!;

                    if (priceChange24 < 0) {
                      return Text(
                        "${pricechangepercentage.toStringAsFixed(2)}% (${priceChange24.toStringAsFixed(4)})",
                        style: const TextStyle(color: Colors.red, fontSize: 23),
                      );
                    } else {
                      return Text(
                        "+${pricechangepercentage.toStringAsFixed(2)}% (${priceChange24.toStringAsFixed(4)})",
                        style: const TextStyle(color: Colors.green),
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    titleandDetail(
                        "Market Cap",
                        "₹${currentCrypto.marketcap!.toStringAsFixed(4)}",
                        CrossAxisAlignment.start),
                    titleandDetail(
                        "Market Cap Rank",
                        "₹${currentCrypto.marketcaprank!.toString()}",
                        CrossAxisAlignment.end),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    titleandDetail(
                        "High 24h",
                        "₹${currentCrypto.high24!.toStringAsFixed(4)}",
                        CrossAxisAlignment.start),
                    titleandDetail(
                        "Low 24h",
                        "₹${currentCrypto.low24!.toStringAsFixed(4)}",
                        CrossAxisAlignment.end),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleandDetail(
                          "Circulation Supply",
                          "₹${currentCrypto.circulatingsupply!.toInt().toString()}",
                          CrossAxisAlignment.start),
                    ]),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleandDetail(
                          "All Time Low",
                          "₹${currentCrypto.atl!.toStringAsFixed(4)}",
                          CrossAxisAlignment.start),
                      titleandDetail(
                          "All Time High",
                          "₹${currentCrypto.ath!.toStringAsFixed(4)}",
                          CrossAxisAlignment.end),
                    ]),
              ],
            );
          }),
        ),
      ),
    );
  }
}
