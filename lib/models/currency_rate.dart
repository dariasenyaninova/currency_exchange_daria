class CurrencyRate {
  final double rate;

  CurrencyRate({required this.rate});

  factory CurrencyRate.fromJson(Map<String, dynamic> json) {
    return CurrencyRate(rate: (json['data']['EUR'] as double).toDouble());
  }
}
