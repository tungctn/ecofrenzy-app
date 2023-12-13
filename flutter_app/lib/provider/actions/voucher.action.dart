import 'package:flutter_app/provider/notifiers/voucher.notifier.dart';
import 'package:flutter_app/services/voucher.service.dart';

class VoucherActions {
  static Future<void> fetchVoucher(VoucherNotifier notifier) async {
    try {
      List<dynamic> fetchVouchers = await VoucherService().fetchVouchers();

      notifier.setVouchers(fetchVouchers);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> fetchVouchersCategory(VoucherNotifier notifier) async {
    try {
      List<dynamic> fetchVouchersCategory =
          await VoucherService().fetchVouchersCategory();

      notifier.setVouchersCategory(fetchVouchersCategory);
    } catch (error) {
      rethrow;
    }
  }
}
