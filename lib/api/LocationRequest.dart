class LocationRequest {
  final int priceMax;
  final int priceMin;
  final int sizeMax;
  final int sizeMin;
  final int roomsMax;
  final int roomsMin;
  final String text;

  LocationRequest({
    required this.priceMax,
    required this.priceMin,
    required this.sizeMax,
    required this.sizeMin,
    required this.roomsMax,
    required this.roomsMin,
    required this.text,
  });

  Map<String, dynamic> toJson() => {
        'price_max': priceMax,
        'price_min': priceMin,
        'size_max': sizeMax,
        'size_min': sizeMin,
        'rooms_n_max': roomsMax,
        'rooms_n_min': roomsMin,
        'text': text,
      };
}
