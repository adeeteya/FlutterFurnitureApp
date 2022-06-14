import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/models/product.dart';

class HomeController extends GetxController {
  final _supabaseInstance = Supabase.instance;
  var selectedCategory = 0.obs;
  var productsList = <Product>[].obs;

  void changeCategory(int categoryId) {
    if (selectedCategory.value == categoryId) return;
    selectedCategory.value = categoryId;
    getProducts(categoryId);
  }

  Future getProducts(int categoryId) async {
    final response = (categoryId == 0)
        ? await _supabaseInstance.client.from('Products').select().execute()
        : await _supabaseInstance.client
            .from('Products')
            .select()
            .eq('categoryId', categoryId)
            .execute();
    List responseList = response.data;
    productsList.value = responseList
        .map((productResponse) => Product.fromJson(productResponse))
        .toList();
  }
}
