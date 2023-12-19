import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/core/utils/help_utils.dart';
import 'package:flutter_app/provider/actions/auth.action.dart';
import 'package:flutter_app/provider/actions/voucher.action.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/provider/notifiers/voucher.notifier.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:provider/provider.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({Key? key}) : super(key: key);

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  final authNotifier = AuthNotifier();
  final voucherNotifier = VoucherNotifier();
  bool _isLoading = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadVoucher();
  }

  void loadVoucher() async {
    await VoucherActions.fetchVouchersCategory(context.read<VoucherNotifier>());
    await VoucherActions.fetchVoucher(context.read<VoucherNotifier>());
    await AuthActions.checkAuth(authNotifier);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getCategoryName(int categoryId, List<dynamic> dataVoucherCategory) {
    dynamic category = dataVoucherCategory.firstWhere(
        (element) => element["id"] == categoryId,
        orElse: () => null);

    if (category == null) {
      return "ShopeeLive";
    } else {
      return category["title"].toString();
    }
  }

  Widget _buildVoucher(dynamic dataVoucher, List<dynamic> dataVoucherCategory) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataVoucher == null ? 0 : dataVoucher.length,
        itemBuilder: (context, index) {
          final dynamic voucher = dataVoucher[index];
          return Container(
              margin: const EdgeInsets.only(
                  bottom: 18, top: 14, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 260,
                    width: 350,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 124, 201, 161),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(left: 14, top: 14),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 58,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      image: DecorationImage(
                                        image: NetworkImage(dataVoucher[index]
                                                ["avatar"] ??
                                            'https://v-images.bloggiamgia.vn//thumbnail/07-07-2022/Ellipse-16-1657165581865.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    getCategoryName(
                                        dataVoucher[index]["couponCategoryId"],
                                        dataVoucherCategory),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "Ridley Grotesk ExtraBold",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    dataVoucher[index]["offer"].toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "Ridley Grotesk ExtraBold",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Giảm ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        dataVoucher[index]["discountReward"] ==
                                                null
                                            ? ""
                                            : HelpUtils.formatNumberToK(
                                                dataVoucher[index]
                                                    ["discountReward"]),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                            color: Color(0xFFFFFE00)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                      width: 200,
                                      child: Expanded(
                                          child: RichText(
                                              text: TextSpan(
                                        text: 'Đơn tối thiểu: ',
                                        style: const TextStyle(
                                            fontFamily:
                                                "Ridley Grotesk Regular",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.white),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: dataVoucher[index]
                                                          ["minSpend"] ==
                                                      null
                                                  ? "Chưa có"
                                                  : HelpUtils.formatNumberToK(
                                                      dataVoucher[index]
                                                          ["minSpend"]),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ],
                                      )))),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                      width: 200,
                                      child: RichText(
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        text: TextSpan(
                                          text: 'Hạn sử dụng: ',
                                          style: const TextStyle(
                                              fontFamily:
                                                  "Ridley Grotesk Regular",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.white),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: dataVoucher[index]
                                                            ["expiredAt"] ==
                                                        null
                                                    ? "Không có"
                                                    : HelpUtils
                                                        .CalExpDateFromNowWithSecond(
                                                            dataVoucher[index]
                                                                ["expiredAt"]),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      const Text("Điểm cần đổi: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.white)),
                                      Text(
                                          dataVoucher[index]["couponCategoryId"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Colors.white))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                        Row(
                          children: [
                            Container(
                              height: 34,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                            ),
                            Expanded(
                                child: Container(
                              color: Colors.white,
                              height: 2,
                            )),
                            Container(
                              height: 34,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50))),
                            )
                          ],
                        ),
                        Container(
                          height: 40,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorPalette.buttonColor)),
                            onPressed: () {
                              setState(() {});
                            },
                            child: const Text("Đổi mã giảm giá",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VoucherNotifier>(builder: (context, notifier, _) {
      // print(notifier.suggestFriends);
      if (_isLoading) {
        return const Center(
          child: Loading(),
        );
      }

      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Mã giảm giá hot',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          body: Consumer<AuthNotifier>(builder: (context, authNotifier, _) {
            if (authNotifier.user == null) {
              return const Center(
                child: Loading(),
              );
            }
            return Column(
              children: [
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, right: 10, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                      border: Border.all(color: Colors.grey)),
                  child: Container(
                    margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: const Text(
                            "Điểm của bạn",
                            style: TextStyle(
                                color: Color(0xff5b6172),
                                fontSize: 26.0,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          child: Text(
                            authNotifier.user!["totalPoint"].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF444B8C),
                              fontSize: 40,
                              fontFamily: "Ridley Grotesk ExtraBold",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: NavigationBarTheme(
                      data: NavigationBarThemeData(
                        indicatorColor: Colors.transparent,
                        iconTheme: MaterialStateProperty.all(
                          const IconThemeData(color: Colors.black),
                        ),
                        labelTextStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.black),
                        ),
                      ),
                      child: NavigationBar(
                        elevation: 100,
                        backgroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        height: 36,
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: _onItemTapped,
                        destinations: [
                          NavigationDestination(
                            icon: SizedBox(
                              width: 150,
                              height: 50,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: _selectedIndex == 0
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 2))),
                                child: const Text(
                                  "Tất cả MGG",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff5b6172),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            label: '',
                          ),
                          NavigationDestination(
                            icon: SizedBox(
                              width: 150,
                              height: 50,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: _selectedIndex == 1
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 2))),
                                child: const Text(
                                  "Lịch sử đổi MGG",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff5b6172),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            label: '',
                          ),
                        ],
                      ),
                    )),
                _buildVoucher(notifier.vouchers, notifier.vouchersCategory)
              ],
            );
          }));
    });
  }
}
