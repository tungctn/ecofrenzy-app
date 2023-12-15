import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/core/utils/help_utils.dart';
import 'package:flutter_app/core/utils/toast_utils.dart';
import 'package:flutter_app/provider/actions/auth.action.dart';
import 'package:flutter_app/provider/actions/user.action.dart';
import 'package:flutter_app/provider/actions/voucher.action.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/provider/notifiers/user.notifier.dart';
import 'package:flutter_app/provider/notifiers/voucher.notifier.dart';
import 'package:flutter_app/services/request.service.dart';
import 'package:flutter_app/views/components/shared/line_widget.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  dynamic _voucherSelected = null;
  int pointUser = 0;

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
    setState(() {
      pointUser = authNotifier.user["totalPoint"];
    });
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

  Widget buildConfirmDialog(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Đổi voucher'),
      content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Bạn có chắc muốn đổi voucher giảm " +
                (_voucherSelected["discountReward"] == null
                    ? ""
                    : HelpUtils.formatNumberToK(
                        _voucherSelected["discountReward"])) +
                " cho đơn từ " +
                (HelpUtils.formatNumberToVND(_voucherSelected["minSpend"])) +
                " không?",
            style: TextStyle(fontSize: 16),
          )),
      actions: [
        ElevatedButton(
            child: Text("Hủy"),
            onPressed: () {
              setState(() {
                _voucherSelected = null;
                Navigator.of(context).pop();
              });
            }),
        ElevatedButton(
            child: Text("Đồng ý"),
            onPressed: () async {
              Navigator.of(context).pop();
              showDialog(context: context, builder: buildVoucherReedemDialog);
              await UserActions.updateUser({
                'totalPoint': pointUser - _voucherSelected["couponCategoryId"]
              });
              await AuthActions.checkAuth(authNotifier);
              setState(() {
                pointUser = authNotifier.user["totalPoint"];
              });
            })
      ],
    );
  }

  Widget buildVoucherReedemDialog(BuildContext context) {
    print(_voucherSelected);
    return AlertDialog(
      scrollable: true,
      title: Text('Đổi voucher thành công!'),
      content: Container(
          margin: EdgeInsets.only(bottom: 18, top: 14, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 160,
                width: 400,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 124, 201, 161),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 14, top: 14, right: 14),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Giảm ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                _voucherSelected["discountReward"] == null
                                    ? ""
                                    : HelpUtils.formatNumberToK(
                                        _voucherSelected["discountReward"]),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                    color: Color(0xFFFFFE00)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Đơn tối thiểu: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Text(
                                HelpUtils.formatNumberToVND(
                                    _voucherSelected["minSpend"]),
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text("Hạn sử dụng: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.white)),
                              Text(
                                _voucherSelected["expiredAt"] == null
                                    ? "Không có"
                                    : HelpUtils.CalExpDateFromNowWithSecond(
                                        _voucherSelected["expiredAt"]),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text("Mã coupon: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.white)),
                              Text(
                                _voucherSelected["couponCode"] == null ||
                                        _voucherSelected["couponCode"] == ""
                                    ? "Không có"
                                    : _voucherSelected["couponCode"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
      actions: [
        ElevatedButton(
            child: Text("Đóng"),
            onPressed: () {
              setState(() {
                _voucherSelected = null;
                Navigator.of(context).pop();
              });
            }),
        ElevatedButton(
            child: Text("Sử dụng ngay"),
            onPressed: () {
              launchUrl(Uri.parse(_voucherSelected["affLink"]));
            })
      ],
    );
  }

  Widget _buildVoucher(dynamic dataVoucher, List<dynamic> dataVoucherCategory) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataVoucher == null ? 0 : dataVoucher.length,
        itemBuilder: (context, index) {
          final dynamic voucher = dataVoucher[index];
          return Container(
              margin: EdgeInsets.only(bottom: 18, top: 14, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 124, 201, 161),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          padding:
                              EdgeInsets.only(left: 14, top: 14, right: 14),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 58,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      image: DecorationImage(
                                        image: NetworkImage(dataVoucher[index]
                                                    ["avatar"] !=
                                                null
                                            ? dataVoucher[index]["avatar"]
                                            : 'https://v-images.bloggiamgia.vn//thumbnail/07-07-2022/Ellipse-16-1657165581865.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    getCategoryName(
                                        dataVoucher[index]["couponCategoryId"],
                                        dataVoucherCategory),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "Ridley Grotesk ExtraBold",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    dataVoucher[index]["offer"].toString(),
                                    style: TextStyle(
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
                                      Text(
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                            color: Color(0xFFFFFE00)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Đơn tối thiểu: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        HelpUtils.formatNumberToVND(
                                            dataVoucher[index]["minSpend"]),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Text("Hạn sử dụng: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.white)),
                                      Text(
                                        dataVoucher[index]["expiredAt"] == null
                                            ? "Không có"
                                            : HelpUtils
                                                .CalExpDateFromNowWithSecond(
                                                    dataVoucher[index]
                                                        ["expiredAt"]),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Text("Điểm cần đổi: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.white)),
                                      Text(
                                          dataVoucher[index]["couponCategoryId"]
                                              .toString(),
                                          style: TextStyle(
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
                              decoration: BoxDecoration(
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50))),
                            )
                          ],
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(bottom: 12),
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorPalette.buttonColor)),
                            onPressed: () {
                              setState(() {
                                _voucherSelected = voucher;

                                if (_voucherSelected["couponCategoryId"] >
                                    pointUser) {
                                  ToastUtils.showToast(
                                      context,
                                      "Bạn không đủ điểm để đổi mã giảm giá này.",
                                      TypeToast.error);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: buildConfirmDialog);
                                }
                              });
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
        body: Column(
          children: [
            Container(
              height: 65,
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
                margin: const EdgeInsets.only(left: 26.0, right: 26.0),
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
                        pointUser.toString(),
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
        ),
      );
    });
  }
}
