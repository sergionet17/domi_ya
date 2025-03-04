import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu.dart';

class MenuService {
  final CollectionReference menuCollection =
  FirebaseFirestore.instance.collection('almuerzos');

  Stream<List<Menu>> getMenus() {
    return menuCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Menu.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
