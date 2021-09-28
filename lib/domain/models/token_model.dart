class TokenModel {
  TokenModel({this.name, this.symbol, this.derivedETH, this.price, this.decimals});

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
      name: (json['name'] != null) ? json['name'] as String : null,
      symbol: (json['symbol'] != null) ? json['symbol'] as String : null,
      derivedETH: (json['derivedETH'] != null) ? json['derivedETH'] as String : null,
      decimals: (json['decimals'] != null) ? json['decimals'] as String : null
  );

  final String? name;
  final String? symbol;
  final String? derivedETH;
  final String? decimals;
  double? price;

  int getDecimalsInt() {
    return int.parse(decimals ?? '0');
  }
}