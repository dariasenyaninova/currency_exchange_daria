import 'package:flutter/material.dart';
import '../services/currency_service.dart';
import '../models/currency_rate.dart';
import '../widgets/exchange_input.dart';

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  double _exchangeRate = 0.0;
  double _convertedAmount = 0.0;
  bool _isEurToUsd = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchExchangeRate();
  }

  void _fetchExchangeRate() async {
    try {
      CurrencyService service = CurrencyService();
      CurrencyRate rate = await service.fetchExchangeRate();
      setState(() {
        _exchangeRate = rate.rate;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load exchange rate';
      });
    }
  }

  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      if (_isEurToUsd) {
        _convertedAmount = amount / _exchangeRate;
      } else {
        _convertedAmount = amount * _exchangeRate;
      }
    });
  }

  void _toggleConversionDirection() {
    setState(() {
      _isEurToUsd = !_isEurToUsd;
      _convertCurrency();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchExchangeRate,
          ),
        ],
      ),
      body: Container(
        color: Colors.tealAccent,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ElevatedButton(
              onPressed: _toggleConversionDirection,
              child: Text(_isEurToUsd ? 'Switch to USD to EUR' : 'Switch to EUR to USD'),
            ),
            SizedBox(height: 20),
            ExchangeInput(controller: _amountController, label: _isEurToUsd ? 'Amount in EUR' : 'Amount in USD'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _isEurToUsd
                  ? 'Converted Amount: $_convertedAmount USD'
                  : 'Converted Amount: $_convertedAmount EUR',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}
