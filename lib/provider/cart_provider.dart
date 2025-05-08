

import 'package:appforhelp/models/cart_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartModels>>(
  (ref) => CartNotifier(),
);


 // it is notifier class
class CartNotifier extends StateNotifier<Map<String, CartModels>> {
  CartNotifier() : super({});

// method or functionlity to addProductToCart 
  void addProductToCart({
    required String productName,
    required int productPrice,
    required String categoryName,
    required String image,
    required int quantity,
    required int instock,
    required String productId,
    required String productSize,
    required int discount,
    required String description,
  }) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
          productId: CartModels(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          categoryName: state[productId]!.categoryName,
          image: state[productId]!.image,
          quantity: state[productId]!.quantity + 1,
          instock: state[productId]!.instock,
          productId: state[productId]!.productId,
          productSize: state[productId]!.productSize,
          discount: state[productId]!.discount,
          description: state[productId]!.description,
        ),
      };
    } else {
      state = {
        ...state,
        productId: CartModels(
          productName: productName,
          productPrice: productPrice,
          categoryName: categoryName,
          image: image,
          quantity: quantity,
          instock: instock,
          productId: productId,
          productSize: productSize,
          discount: discount,
          description: description,
        )
      };
    }
  }
  
   // method or function to remove item or product from cart
  void removeToItem(String productId){
    state.remove(productId);
    // notify listeners that the state has changed
    state = {...state};
  }
    
  //  method or function to increment cart item
   // ignore: unused_element
   void incrementItem(String productId){
     if(state.containsKey(productId)){
      state[productId]!.quantity++;
     }
     // notify listeners that the state has changed and also notify to UI that is change thier UI
     state = {...state};
   } 
   //method or function to decrement cart item
   void decrement(String productId){
    if(state.containsKey(productId)){
      final currentItem = state[productId]!;
      if(currentItem.quantity > 1){
        state[productId]!.quantity--;
      }
      //  notify listeners that the state has changed and also notify to UI that is change their UI
      state = {...state};
    }

     void clearCartData(){
      state.clear();
      // notify listeners that the state has changed and also notify to UI that is change their UI
      state = {...state};
     }
   }

   double calculateTotalAmount(){
    double totalAmount = 0.0;

     state.forEach((productId, cartItem) {
       double effectivePrice = cartItem.productPrice - (cartItem.productPrice * cartItem.discount /100);
       totalAmount += effectivePrice * cartItem.quantity;
     },);
     return totalAmount;
   }
  //get the current state details through state into getCartItem using get method
  //Any widget or function can call getCartItem to retrieve all products in the cart.
  
  Map<String , CartModels> get getCartItem => state;
}
