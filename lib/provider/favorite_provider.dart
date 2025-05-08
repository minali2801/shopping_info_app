import 'package:appforhelp/models/favorite_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final favoriteProvider = StateNotifierProvider<FavoriteNotifier,Map<String,FavoriteModels>>((ref){
 return FavoriteNotifier();
});

class FavoriteNotifier  extends StateNotifier<Map<String,FavoriteModels>> {
  FavoriteNotifier() : super({});
 
 // fumction or method that addToFavorite item
 
 void addProductToFavorite({
  required String productName,
  required String productId,
  required String image,
  required int productPrice,
  required int discount,
  required String category,
 }){
      state[productId] = FavoriteModels(
      productName: productName, 
      productId: productId, 
      image: image, 
      productPrice: productPrice,
      discount: discount, 
      category: category ,
      );

      // notify listeners that the state has changed and also UI
      state = {...state};
 }
 // function or method that is remove All item from the favorite
 void removeAllItem(){
  state.clear();

  // notify listeners that the state has changed and also UI
  state = {...state};
 }

 // function or method that is remove item from the favorite
 void removeToItem(String productId){
  state.remove(productId);
  
  // notify listeners that the state has changed and also UI
  state={...state};
 }
 // retirve value from the state object
 Map<String,FavoriteModels> get getFavoriteItem => state;

 
}