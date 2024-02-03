import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/models/product.dart';

class FavoritesController extends GetxController {
  var favoritesList = <Product>[].obs;
  final _supabaseClient = Supabase.instance.client;

  Future<void> fetchFavorites() async {
    final response = await _supabaseClient
        .from("Users")
        .select()
        .eq("Uid", _supabaseClient.auth.currentUser!.id);
    List responseList = response[0]['favoritesList'];
    for (int i = 0; i < responseList.length; i++) {
      final productResponse = await _supabaseClient
          .from('Products')
          .select()
          .eq("product_id", responseList[i]);
      favoritesList.add(Product.fromJson(productResponse[0]));
    }
  }

  Future<void> updateDatabase() async {
    await _supabaseClient.from('Users').update({
      'favoritesList':
          favoritesList.map((favoriteItem) => favoriteItem.productId).toList()
    }).eq("Uid", _supabaseClient.auth.currentUser!.id);
  }

  Future<void> addProduct(Product product) async {
    favoritesList.add(product);
    await updateDatabase();
  }

  Future<void> removeProduct(Product product) async {
    favoritesList.remove(product);
    await updateDatabase();
  }

  Future<void> removeProductAt(int index) async {
    favoritesList.removeAt(index);
    await updateDatabase();
  }
}
