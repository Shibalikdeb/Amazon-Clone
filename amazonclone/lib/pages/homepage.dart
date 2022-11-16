import 'package:amazonclone/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cryptocurrency.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Welcome Back',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              'Crypto Today',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<MarketProvider>(
                builder: (context, marketProvider, child) {
                  if (marketProvider.isLoading == true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (marketProvider.markets.length > 0) {
                      return ListView.builder(
                        itemCount: marketProvider.markets.length,
                        itemBuilder: (context, index) {
                          Cryptocurrency currentCrypto =
                              marketProvider.markets[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(currentCrypto.image!),
                            ),
                            title: Text(currentCrypto.name!),
                          );
                        },
                      );
                    } else {
                      return Text("Data Not Found!");
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
