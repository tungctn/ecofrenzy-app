import 'package:flutter/material.dart';

class VoucherNotifier extends ChangeNotifier {
  // bool get hasPost => post != null;
  List<dynamic> vouchers = [];
  List<dynamic> vouchersCategory = [];

  void setVouchers(List<dynamic> newVouchers) {
    vouchers = newVouchers;
    notifyListeners();
  }

  void setVouchersCategory(List<dynamic> newVouchersCategory) {
    vouchersCategory = newVouchersCategory;
    notifyListeners();
  }
}
