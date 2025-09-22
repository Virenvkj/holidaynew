class CurrencyDetails {
  final String alpha;

  CurrencyDetails({
    required this.alpha,
  });

  factory CurrencyDetails.fromJson(Map<String, dynamic> json) =>
      CurrencyDetails(
        alpha: json["alpha"],
      );

  Map<String, dynamic> toJson() => {
        "alpha": alpha,
      };
}
