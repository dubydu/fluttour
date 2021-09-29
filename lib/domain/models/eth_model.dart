class ETHModel {
  ETHModel({this.data});

  factory ETHModel.fromJson(Map<String, dynamic> json) => ETHModel(
    data: (json['bundle'] != null) ? ETHBundle.fromJson(json['bundle'] as Map<String, dynamic>) : null
  );

  final ETHBundle? data;
}

class ETHBundle {
  ETHBundle({this.ethPrice});

  factory ETHBundle.fromJson(Map<String, dynamic> json) => ETHBundle(
      ethPrice: (json['ethPriceUSD'] != null) ? json['ethPriceUSD'] as String : null
  );

  final String? ethPrice;
}