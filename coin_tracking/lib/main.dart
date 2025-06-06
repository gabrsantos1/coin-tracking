import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coin_tracking/view_models/cryptoListVM.dart';
import 'package:coin_tracking/views/cryptoListHM.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CryptoListViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cotação das Moedas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Color.fromARGB(255, 209, 223, 205),
        ),
        home: CryptoListScreen(),
      ),
    );
  }
}
