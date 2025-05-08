import 'package:appforhelp/models/category_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController  extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }
// ignore: unused_element
void _fetchCategories () {
  _firestore.collection('category')
  .snapshots()
  .listen((QuerySnapshot querySnapshot) {
  categories.assignAll(
    querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String , dynamic>;
      return CategoryModel(
        categoryName: data['categoryName'], 
        categoryImage: data['categoryImage']);
    }).toList(),
  );
  });
}

}