import 'package:get/get.dart';
import 'package:onschedule/models/transaction_model.dart';
import 'package:onschedule/repository/transaction_repository.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final transactionRepo = Get.put(TransactionRepository());

  Future<void> createTransaction(Transactions transactions) async {
    await transactionRepo.createTransaction(transactions);
  }
}
