import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coin_tracking/view_models/crypto_list_view_model.dart';
import 'package:coin_tracking/models/crypto_currency.dart';

class CryptoDetailBottomSheet extends StatelessWidget {
  final CryptoCurrency crypto;

  const CryptoDetailBottomSheet({Key? key, required this.crypto})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            crypto.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Símbolo: ${crypto.symbol}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'Data Adicionada: ${crypto.formattedDateAdded}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Preço USD: ${crypto.formattedPriceUsd}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Preço BRL: ${crypto.formattedPriceBrl}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text =
        Provider.of<CryptoListViewModel>(
          context,
          listen: false,
        ).currentSearchSymbols;

    Future.microtask(
      () =>
          Provider.of<CryptoListViewModel>(
            context,
            listen: false,
          ).fetchCryptoCurrencies(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cotação de Moedas')),
      body: Consumer<CryptoListViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Símbolos (ex: BTC,ETH,SOL)',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (value) {
                          viewModel.setSearchSymbols(value);
                          viewModel.fetchCryptoCurrencies();
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.setSearchSymbols(_searchController.text);
                        viewModel.fetchCryptoCurrencies();
                      },
                      child: Text('Buscar ou Atualizar'),
                    ),
                  ],
                ),
              ),
              if (viewModel.isLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
              if (viewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        viewModel.errorMessage!,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.setSearchSymbols(_searchController.text);
                          viewModel.fetchCryptoCurrencies();
                        },
                        child: Text('Tentar Novamente'),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    viewModel.setSearchSymbols(_searchController.text);
                    await viewModel.fetchCryptoCurrencies();
                  },
                  child:
                      viewModel.cryptoCurrencies.isEmpty &&
                              !viewModel.isLoading &&
                              viewModel.errorMessage == null
                          ? Center(
                            child: Text(
                              'Nenhuma criptomoeda encontrada para os símbolos informados.',
                            ),
                          )
                          : ListView.builder(
                            itemCount: viewModel.cryptoCurrencies.length,
                            itemBuilder: (context, index) {
                              final crypto = viewModel.cryptoCurrencies[index];
                              final percentChangeColor =
                                  crypto.percentChange24h >= 0
                                      ? Colors.green
                                      : Colors.red;

                              return Card(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(crypto.symbol),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  title: Text(crypto.name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('USD: ${crypto.formattedPriceUsd}'),
                                      Text('BRL: ${crypto.formattedPriceBrl}'),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${crypto.percentChange24h.toStringAsFixed(2)}%',
                                        style: TextStyle(
                                          color: percentChangeColor,
                                        ),
                                      ),
                                      Text('24h'),
                                    ],
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CryptoDetailBottomSheet(
                                          crypto: crypto,
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
