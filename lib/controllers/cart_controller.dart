import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/models/cart_item.dart';
import 'package:timberr/models/product.dart';
import 'package:timberr/screens/cart/cart_screen.dart';

class CartController extends GetxController {
  List cartIdList = [];
  var cartList = <CartItem>{}.obs;
  var total = 0.obs;
  final _supabaseClient = Supabase.instance.client;

  Future<void> fetchCartItems() async {
    final response = await _supabaseClient
        .from('Users')
        .select()
        .eq("Uid", _supabaseClient.auth.currentUser!.id);
    cartIdList = response[0]['cartList'];
    for (int i = 0; i < cartIdList.length; i++) {
      final cartResponse = await _supabaseClient
          .from('Cart_Items')
          .select()
          .eq("cart_id", cartIdList[i]);
      final productResponse = await _supabaseClient
          .from('Products')
          .select()
          .eq("product_id", cartResponse[0]['product_id']);
      cartList.add(CartItem(cartIdList[i], cartResponse[0]['quantity'],
          cartResponse[0]['color'], productResponse[0]));
      total.value = total.value +
          (cartList.elementAt(i).quantity * cartList.elementAt(i).price);
    }
  }

  int findProduct(Product product, Color color) {
    for (int i = 0; i < cartList.length; i++) {
      if (cartList.elementAt(i).productId == product.productId &&
          cartList.elementAt(i).color == color) {
        return i;
      }
    }
    return -1;
  }

  Future<void> addToCart(Product product, Color color,
      {int quantity = 1, bool showSnackbar = true}) async {
    int index = findProduct(product, color);
    if (index != -1) {
      //product already present in cart
      cartList.elementAt(index).addQuantity(quantity);
      total.value = total.value + (quantity * cartList.elementAt(index).price);
      //update quantity in database
      await _supabaseClient
          .from('Cart_Items')
          .update({'quantity': cartList.elementAt(index).quantity}).eq(
              "cart_id", cartList.elementAt(index).cartId);
    } else {
      //product not there in cart
      //add item to cart_items database
      final insertData = await _supabaseClient.from("Cart_Items").insert([
        {
          'product_id': product.productId,
          'quantity': quantity,
          'color': colorToString(color),
        }
      ]).select();
      cartList.add(
        CartItem(
          insertData[0]['cart_id'],
          quantity,
          insertData[0]['color'],
          product.toJson(),
        ),
      );
      total.value = total.value + (quantity * product.price);
      //set cart_id in user cartlist
      cartIdList.add(insertData[0]['cart_id']);
      await _supabaseClient.from('Users').update({'cartList': cartIdList}).eq(
          "Uid", _supabaseClient.auth.currentUser!.id);
    }
    if (showSnackbar) {
      Get.snackbar(
        "Added to Cart",
        "${product.name} has been added to the cart",
        onTap: (_) {
          Get.closeCurrentSnackbar();
          Get.to(
            () => CartScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 600),
          );
        },
      );
    }
  }

  Future<void> removeFromCart(CartItem item) async {
    cartList.remove(item);
    cartIdList.remove(item.cartId);
    total.value = total.value - (item.quantity * item.price);
    //remove cart_id from user cart list
    await _supabaseClient.from('Users').update({
      'cartList': cartIdList,
    }).eq("Uid", _supabaseClient.auth.currentUser!.id);
    //remove item from cart_items database
    await _supabaseClient
        .from('Cart_Items')
        .delete()
        .eq("cart_id", item.cartId);
  }

  Future incrementQuantity(CartItem item) async {
    item.addQuantity(1);
    total.value = total.value + item.price;
    await _supabaseClient
        .from('Cart_Items')
        .update({'quantity': item.quantity}).eq("cart_id", item.cartId);
    update();
  }

  Future decrementQuantity(CartItem item) async {
    if (item.quantity == 1) {
      await removeFromCart(item);
    } else {
      item.removeQuantity(1);
      await _supabaseClient
          .from('Cart_Items')
          .update({'quantity': item.quantity}).eq("cart_id", item.cartId);
      total.value = total.value - item.price;
      update();
    }
  }

  Future<void> removeAllFromCart() async {
    cartList.clear();
    //delete each cart entry from the database
    for (int i = 0; i < cartIdList.length; i++) {
      await _supabaseClient
          .from('Cart_Items')
          .delete()
          .eq("cart_id", cartIdList.elementAt(i));
    }
    cartIdList.clear();
    //remove all the elements from the user cart
    await _supabaseClient.from('Users').update({
      'cartList': [],
    }).eq("Uid", _supabaseClient.auth.currentUser!.id);
  }
}
