class CardDetail {
  int id;
  String name;
  int cardNumber;
  int month;
  int year;
  CardDetail(
      {required this.id,
      required this.name,
      required this.cardNumber,
      required this.month,
      required this.year});
  factory CardDetail.fromJson(Map<String, dynamic> json) {
    return CardDetail(
        id: json['id'],
        name: json['cardholder_name'],
        cardNumber: json['card_number'],
        month: json['month'],
        year: json['year']);
  }
}
