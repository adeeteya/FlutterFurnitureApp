class Address {
  late int id;
  String name;
  String address;
  int pincode;
  String country;
  String city;
  String district;
  Address({
    required this.id,
    required this.name,
    required this.address,
    required this.pincode,
    required this.country,
    required this.city,
    required this.district,
  });
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['full_name'],
      address: json['address'],
      pincode: json['pincode'],
      country: json['country'],
      city: json['city'],
      district: json['district'],
    );
  }
  String displayAddress() {
    return "$address, $district, $city, $pincode";
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "full_name": name,
      "address": address,
      "pincode": pincode,
      "country": country,
      "city": city,
      "district": district
    };
  }
}
