class Address {
  String street;
  String city;
  String state;
  String zipCode;
  String country;
  double? lat;
  double? lng;

  Address({
    required this.street,
    required this.city,
    required this.state,required this.zipCode,
    required this.country,
    this.lat,
    this.lng
  });

  String get formattedAddress {
    return '$street, $city, $state $zipCode, $country';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      lat: json['lat'] as double?,
      lng: json['lng'] as double?,
    );
  }

  

  factory Address.fromDB(Map json) {
    return Address(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      lat: json['lat'] as double?,
      lng: json['lng'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'lat': lat,
      'lng': lng,
    };
  }
}