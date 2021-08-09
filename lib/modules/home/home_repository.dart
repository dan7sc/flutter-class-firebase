import 'package:class_firebase/shared/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepository {
  static Future<bool> containsEmail(String email) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection("/users")
          .where("email", isEqualTo: email)
          .where("created", isGreaterThanOrEqualTo: DateTime(2021, 7, 29))
          .get();
      print('ContainsEmail: ${response.docs.length > 0}');
      return response.docs.length > 0;
    } catch (e) {
      print('ErrorContainsEmail: $e');
      throw e;
    }
  }

  static Future<bool> createTransaction(UserData? user) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("/transactions").add({
        "userId": user?.uid,
        "value": 1000,
        "type": "in",
        "createdAt": FieldValue.serverTimestamp()
      });
      print('CreateTransaction: $response.docs');
      return true;
    } catch (e) {
      print('ErrorCreateTransaction: $e');
      throw e;
    }
  }

  static Future<bool> transactionsByUser(UserData? user) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection("/transactions")
          .where("userId", isEqualTo: user?.uid)
          .where("type", isEqualTo: "in")
          .get();
      print('TransactionsByUser: ${response.docs.map(((e) => e.data()))}');
      return true;
    } catch (e) {
      print('ErrorTransactionsByUser: $e');
      throw e;
    }
  }
}
