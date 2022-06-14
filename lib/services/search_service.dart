import 'package:supabase_flutter/supabase_flutter.dart';

class SearchService {
  final _supabaseClient = Supabase.instance.client;
  Future searchProduct(String query) async {
    final response = await _supabaseClient
        .from('Products')
        .select()
        .textSearch("name", "'$query'")
        .execute();
    List responseList = response.data;
    return responseList;
  }
}
