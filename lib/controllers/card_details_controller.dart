import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/models/card_detail.dart';

class CardDetailsController extends GetxController {
  final _supabaseClient = Supabase.instance.client;
  var cardDetailList = <CardDetail>[].obs;
  var selectedIndex = 0.obs;

  String getLastFourDigits() {
    if (cardDetailList.isNotEmpty) {
      return cardDetailList
          .elementAt(selectedIndex.value)
          .cardNumber
          .toString()
          .substring(12);
    }
    return "XXXX";
  }

  Future<void> fetchCardDetails() async {
    //fetch Card Details
    final response = await _supabaseClient.from("Card_Details").select().eq(
          "user_id",
          _supabaseClient.auth.currentUser!.id,
        );
    final responseList = response;
    for (int i = 0; i < responseList.length; i++) {
      cardDetailList.add(CardDetail.fromJson(responseList[i]));
    }
  }

  Future<void> getDefaultCardDetail() async {
    //get default card detail
    final defaultShippingResponse =
        await _supabaseClient.from("Users").select('default_card_detail_id').eq(
              "Uid",
              _supabaseClient.auth.currentUser!.id,
            );
    int? responseId = defaultShippingResponse[0]['default_card_detail_id'];
    await fetchCardDetails();
    if (responseId != null) {
      for (int i = 0; i < cardDetailList.length; i++) {
        if (cardDetailList.elementAt(i).id == responseId) {
          selectedIndex.value = i;
          break;
        }
      }
    }
  }

  Future<void> setDefaultCardDetail(int index) async {
    if (selectedIndex.value == index) {
      return;
    }
    selectedIndex.value = index;
    await _supabaseClient.from("Users").update(
        {'default_card_detail_id': cardDetailList.elementAt(index).id}).eq(
      "Uid",
      _supabaseClient.auth.currentUser!.id,
    );
  }
}
