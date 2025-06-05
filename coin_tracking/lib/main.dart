import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coin_tracking/view_models/crypto_list_view_model.dart';
import 'package:coin_tracking/views/crypto_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CryptoListViewModel())],
      child: MaterialApp(
        title: 'Cotação das Moedas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CryptoListScreen(),
      ),
    );
  }
}
