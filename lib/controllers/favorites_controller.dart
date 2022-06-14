import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/models/product.dart';

class FavoritesController extends GetxController {
  var favoritesList = <Product>[].obs;
  final _supabaseClient = Supabase.instance.client;

  Future fetchFavorites() async {
    final response = await _supabaseClient
        .from("Users")
        .select()
        .eq("Uid", _supabaseClient.auth.currentUser?.id)
        .execute();
    List responseList = response.data[0]['favoritesList'];
    for (int i = 0; i < responseList.length; i++) {
      final productResponse = await _supabaseClient
          .from('Products')
          .select()
          .eq("product_id", responseList[i])
          .execute();
      favoritesList.add(Product.fromJson(productResponse.data[0]));
    }
  }

  void updateDatabase() {
    _supabaseClient
        .from('Users')
        .update({
          'favoritesList': favoritesList
              .map((favoriteItem) => favoriteItem.productId)
              .toList()
        })
        .eq("Uid", _supabaseClient.auth.currentUser?.id)
        .execute();
  }

  void addProduct(Product product) {
    favoritesList.add(product);
    updateDatabase();
  }

  void removeProduct(Product product) {
    favoritesList.remove(product);
    updateDatabase();
  }

  void removeProductAt(int index) {
    favoritesList.removeAt(index);
    updateDatabase();
  }
}
