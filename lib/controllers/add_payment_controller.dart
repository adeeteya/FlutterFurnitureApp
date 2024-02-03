import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/controllers/card_details_controller.dart';
import 'package:timberr/models/card_detail.dart';

class AddPaymentController extends GetxController {
  int cardNumber = 0, cvv = 0, month = 0, year = 0;
  var name = "".obs;
  var dateString = "".obs;
  var lastFourDigits = "".obs;
  final _supabaseClient = Supabase.instance.client;
  final CardDetailsController _cardDetailsController = Get.find();

  Future<void> addCardDetail() async {
    final insertData = await _supabaseClient.from("Card_Details").insert({
      "cardholder_name": name.value,
      "card_number": cardNumber,
      "month": month,
      "year": year,
      "user_id": _supabaseClient.auth.currentUser!.id
    }).select();
    if (_cardDetailsController.cardDetailList.isEmpty) {
      _cardDetailsController.selectedIndex.value = 0;
      //set default user Card Id in the database
      await _supabaseClient
          .from("Users")
          .update({'default_card_detail_id': insertData[0]['id']}).eq(
        "Uid",
        _supabaseClient.auth.currentUser!.id,
      );
    }
    _cardDetailsController.cardDetailList.add(
      CardDetail(
        id: insertData[0]['id'],
        name: name.value,
        cardNumber: cardNumber,
        month: month,
        year: year,
      ),
    );
    Get.back();
  }
}
