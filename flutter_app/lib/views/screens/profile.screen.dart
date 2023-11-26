import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/provider/actions/activity.action.dart';
import 'package:flutter_app/provider/actions/auth.action.dart';
import 'package:flutter_app/provider/notifiers/activity.notifier.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/views/components/profile/activity.card.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class Activity {
  final String name;
  final String location;
  final int achieve;

  const Activity({
    Key? key,
    required this.name,
    required this.location,
    required this.achieve,
  });
}

class ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  int _selectedIndex = 0;
  List<Activity> activities = [];
  final activityNotifier = ActivityNotifier();
  final authNotifier = AuthNotifier();

  final activities_data = [
    {
      "name": "Hoạt động 1",
      "location": "Địa điểm 1",
      "achieve": 1,
    },
    {
      "name": "Hoạt động 2",
      "location": "Địa điểm 2",
      "achieve": 2,
    },
    {
      "name": "Hoạt động 3",
      "location": "Địa điểm 3",
      "achieve": 3,
    },
    {
      "name": "Hoạt động 4",
      "location": "Địa điểm 4",
      "achieve": 4,
    }
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildInfo() {
    switch (_selectedIndex) {
      case 0:
        return Column(
          children: activityNotifier.activities.map<Widget>((activity) {
            return ActivityCard(
                name: activity['name'] as String,
                location: "Ha Noi",
                achieve: activity['point'] as int,
                category: activity['category'] as String,
                );
          }).toList(),
        );
      case 1:
        return const Text("1");
      case 2:
        return const Text("2");
      default:
        return const Text("0");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadProfile();
  }

  void loadProfile() async {
    await AuthActions.checkAuth(context.read<AuthNotifier>());
    await ActivityActions.getActivities(activityNotifier);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, notifier, _) {
      return Scaffold(
          body: _isLoading
              ? const Loading()
              : Stack(
                  children: <Widget>[
                    Container(
                      // color: ColorPalette.primaryColor,
                      color: Colors.white,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      top: -80,
                      left: -60,
                      child: Image.asset(
                        'assets/images/background_profile.png',
                        width: 680.23,
                        height: 373.44,
                      ),
                    ),
                    Column(children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            margin: const EdgeInsets.only(left: 16, top: 22),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 290,
                        child: Stack(children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  top: 70, left: 20, right: 20),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: 352,
                              height: 221,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    notifier.user['name'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      // fontFamily: "Ridley Grotesk ExtraBold",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Thành viên từ 2021',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF6C7A9C),
                                      fontSize: 14,
                                      fontFamily: "Ridley Grotesk ExtraBold",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              notifier.user['points']
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color(0xFF444B8C),
                                                fontSize: 16,
                                                fontFamily:
                                                    "Ridley Grotesk ExtraBold",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            const Text(
                                              'Points',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF444B8C),
                                                fontSize: 13.12,
                                                fontFamily:
                                                    "Ridley Grotesk ExtraBold",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              notifier.user['friends'].length
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color(0xFF444B8C),
                                                fontSize: 16,
                                                fontFamily:
                                                    "Ridley Grotesk ExtraBold",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            const Text(
                                              'Friends',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF444B8C),
                                                fontSize: 13.12,
                                                fontFamily:
                                                    "Ridley Grotesk ExtraBold",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.19),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x7F5790DF),
                                              blurRadius: 20.19,
                                              offset: Offset(0, 10.09),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: ElevatedButton.icon(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF7367F0),
                                            foregroundColor: Colors.white,
                                          ),
                                          icon: const Icon(Icons.add),
                                          label: const Text('Thay avatar'),
                                        ),
                                      ),
                                      // Container(
                                      //   width: 150,
                                      //   decoration: ShapeDecoration(
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(20.19),
                                      //     ),
                                      //     shadows: const [
                                      //       BoxShadow(
                                      //         color: Color(0x7F5790DF),
                                      //         blurRadius: 20.19,
                                      //         offset: Offset(0, 10.09),
                                      //         spreadRadius: 0,
                                      //       )
                                      //     ],
                                      //   ),
                                      //   child: ElevatedButton.icon(
                                      //     onPressed: () {},
                                      //     style: ElevatedButton.styleFrom(
                                      //       backgroundColor: Colors.white,
                                      //       foregroundColor: Colors.black,
                                      //     ),
                                      //     icon: const Icon(FontAwesomeIcons.paperPlane,
                                      //         size: 15),
                                      //     label: const Text('Challenge'),
                                      //   ),
                                      // )
                                    ],
                                  )
                                ],
                              )),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 120, right: 120),
                            child: IconButton(
                              icon: Image.network(
                                notifier.user['image'],
                                width: 99,
                                height: 99,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      // Container(
                      //   decoration: const BoxDecoration(color: Colors.transparent),
                      //   child: NavigationBar(
                      //     elevation: 100,
                      //     backgroundColor: Colors.transparent,
                      //     surfaceTintColor: Colors.transparent,
                      //     height: 36,
                      //     selectedIndex: _selectedIndex,
                      //     onDestinationSelected: _onItemTapped,
                      //     destinations: const [
                      //       NavigationDestination(
                      //           icon: Icon(FontAwesomeIcons.waveSquare),
                      //           label: "Activities"),
                      //       NavigationDestination(
                      //           icon: Icon(FontAwesomeIcons.camera), label: "Photos"),
                      //       NavigationDestination(
                      //           icon: Icon(FontAwesomeIcons.film), label: "Videos")
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 500,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                          child: buildInfo(),
                        ),
                      ),
                    ]),
                  ],
                ));
    });
  }
}
