import 'package:amazonclone/providers/market_provider.dart';
import 'package:amazonclone/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'markets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Crypto Today',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                  padding: EdgeInsets.all(0),
                  icon: (themeProvider.themeMode == ThemeMode.light)
                      ? Icon(Icons.dark_mode)
                      : Icon(Icons.light_mode),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<MarketProvider>(
                builder: (context, marketProvider, child) {
                  if (marketProvider.isLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (marketProvider.markets.length > 0) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: marketProvider.markets.length,
                        itemBuilder: (context, index) {
                          Cryptocurrency currentCrypto =
                              marketProvider.markets[index];
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
                              backgroundImage:
                                  NetworkImage(currentCrypto.image!),
                            ),
                            title: Text(
                                "${currentCrypto.name!} #${currentCrypto.marketcaprank!}"),
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
                                    double priceChange24 =
                                        currentCrypto.priceChange24!;
                                    double pricechangepercentage =
                                        currentCrypto.pricechangepercentage24!;

                                    if (priceChange24 < 0) {
                                      return Text(
                                        "${pricechangepercentage.toStringAsFixed(2)}% (${priceChange24.toStringAsFixed(4)})",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      );
                                    } else {
                                      return Text(
                                        "+${pricechangepercentage.toStringAsFixed(2)}% (${priceChange24.toStringAsFixed(4)})",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text("Data Not Found!");
                    }
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
