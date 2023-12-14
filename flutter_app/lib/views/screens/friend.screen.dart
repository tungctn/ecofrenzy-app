import 'package:flutter/material.dart';
import 'package:flutter_app/provider/actions/auth.action.dart';
import 'package:flutter_app/provider/actions/user.action.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/provider/notifiers/user.notifier.dart';
import 'package:flutter_app/services/request.service.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final List<Map<String, dynamic>> friends = [
    {
      'name': 'Alex Nguyen',
      'location': 'Hanoi',
      'points': '50 PT',
      'added': false,
      'image': 'assets/images/avatar.png'
    },
    {
      'name': 'Jordan',
      'location': 'Saigon',
      'points': '50 PT',
      'added': true,
      'image': 'assets/images/avatar.png'
    },
    {
      'name': 'Jordan',
      'location': 'Saigon',
      'points': '50 PT',
      'added': false,
      'image': 'assets/images/avatar.png'
    },
    {
      'name': 'Jordan',
      'location': 'Saigon',
      'points': '50 PT',
      'added': true,
      'image': 'assets/images/avatar.png'
    },
    {
      'name': 'Jordan',
      'location': 'Saigon',
      'points': '50 PT',
      'added': false,
      'image': 'assets/images/avatar.png'
    },
  ];
  final List<String> friendImages = [
    "assets/images/avatar.png",
    "assets/images/avatar.png",
    "assets/images/avatar.png",
    // "assets/images/avatar.png",
  ];
  final userNotifier = UserNotifier();
  final authNotifier = AuthNotifier();
  bool _isLoading = false;
  final List<bool> _addedStatus = [];
  final List<bool> _requestStatus = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _addedStatus.addAll(List.generate(5, (index) => false));
    _requestStatus.addAll(List.generate(5, (index) => false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadSuggestFriend();
  }

  void loadSuggestFriend() async {
    await UserActions.fetchSuggestFriend(context.read<UserNotifier>());
    await UserActions.fetchFriends(context.read<UserNotifier>());
    await UserActions.fetchRequestsPendingByUser(context.read<UserNotifier>());
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

  Widget _buildFriend(dynamic dataFriend) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataFriend == null ? 0 : dataFriend.length,
        itemBuilder: (context, index) {
          final friend = dataFriend[index];
          return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(_selectedIndex == 0
                          ? friend["requester"]["image"]
                          : friend["image"]),
                      radius: 20,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow,
                          ),
                        ),
                        TextSpan(
                          text: _selectedIndex == 0
                              ? "${friend["requester"]['totalPoint'].toString()} PT"
                              : "${friend['totalPoint'].toString()} PT",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ]),
                    ),
                  ],
                ),
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: _selectedIndex == 0
                          ? friend["requester"]['name']
                          : friend['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const WidgetSpan(
                      child: Icon(
                        Icons.verified,
                        size: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ]),
                ),
                // subtitle: Text(friend['location']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: "Ha Noi",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ]),
                    ),
                  ],
                ),

                trailing: ElevatedButton(
                  onPressed: () {
                    _selectedIndex == 0
                        ? RequestService().updateRequest(friend["_id"], "2")
                        : RequestService().createRequest(friend["_id"]);

                    _selectedIndex == 0
                        ? setState(() {
                            _requestStatus[index] = true;
                          })
                        : setState(() {
                            _addedStatus[index] = true;
                          });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5F2AC5),
                  ),
                  child: Text(
                      _selectedIndex == 0
                          ? _requestStatus[index]
                              ? 'ACCEPTED'
                              : 'ACCEPT'
                          : _addedStatus[index]
                              ? 'ADDED'
                              : 'ADD',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(builder: (context, notifier, _) {
      // print(notifier.suggestFriends);
      if (_isLoading) {
        return Center(
          child: Container(
            color: Colors.white,
            child: Loading(),
          ),
        );
      }
      dynamic listRequests = notifier.requests
          .map((element) => element["requester"]["_id"])
          .toList();
      dynamic listSuggestFriend = notifier.suggestFriends
          .map((e) {
            if (!listRequests.contains(e["_id"])) {
              return e;
            } else {
              return null;
            }
          })
          .where((e) => e != null)
          .toList();
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF38EB86), Color(0xFF39F5C4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            'Social network friends',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
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
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5.0),
                            child: const Text(
                              "Your friends",
                              style: TextStyle(
                                  color: Color(0xff5b6172),
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              "You have ${authNotifier.user["friends"].length.toString()} friends",
                              style: const TextStyle(
                                color: Color(0xff5b6172),
                                fontSize: 14.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 50,
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage(friendImages[0]),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage(friendImages[1]),
                            ),
                          ),
                          Positioned(
                            left: 60,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage(friendImages[2]),
                            ),
                          )
                        ],
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
                          width: 120,
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
                              "Lời mời kết bạn",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff5b6172),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        label: '',
                      ),
                      NavigationDestination(
                        icon: SizedBox(
                          width: 110,
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
                              "Gợi ý kết bạn",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff5b6172),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        label: '',
                      ),
                    ],
                  ),
                )),
            _selectedIndex == 0
                ? _buildFriend(notifier.requests)
                : _buildFriend(listSuggestFriend),
          ],
        ),
      );
    });
  }
}
