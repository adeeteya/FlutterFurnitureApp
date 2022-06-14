class UserData {
  String name;
  String email;
  String? profilePictureUrl;
  bool newArrivalsNotification;
  bool deliveryStatusNotification;
  bool salesNotification;
  UserData(
      {this.name = "",
      this.email = "",
      this.profilePictureUrl,
      this.newArrivalsNotification = false,
      this.deliveryStatusNotification = true,
      this.salesNotification = true});
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['Name'],
      email: json['Email'],
      profilePictureUrl: json['profile_picture_url'],
      salesNotification: json['sales_notification'],
      deliveryStatusNotification: json['delivery_status_notification'],
    );
  }
}
