import 'package:flutter/material.dart';
import 'package:flutter_app/provider/actions/user.action.dart';
import 'package:flutter_app/provider/notifiers/user.notifier.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
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
  bool _isLoading = false;
  final List<bool> _addedStatus = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _addedStatus.addAll(List.generate(5, (index) => false));
    loadSuggestFriend();
  }

  void loadSuggestFriend() async {
    await UserActions.fetchSuggestFriend(context.read<UserNotifier>());
    await UserActions.fetchFriends(context.read<UserNotifier>());
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(builder: (context, notifier, _) {
      // print(notifier.suggestFriends);
      if (_isLoading) {
        return const Center(
          child: Loading(),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Social network friends',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
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
                              "You have ${notifier.friends.length.toString()} friends",
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
            Expanded(
              child: ListView.builder(
                itemCount: notifier.suggestFriends == null
                    ? 0
                    : notifier.suggestFriends.length,
                itemBuilder: (context, index) {
                  final friend = notifier.suggestFriends[index];
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
                              backgroundImage: NetworkImage(friend["image"]),
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
                                  text: "${friend['points'].toString()} PT",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ]),
                            ),
                          ],
                        ),
                        title: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: friend['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                            setState(() {
                              _addedStatus[index] = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _addedStatus[index]
                                ? Colors.grey
                                : const Color(
                                    0xff5F2AC5), // Màu nút có thể thay đổi
                          ),
                          child: Text(_addedStatus[index] ? 'ADDED' : 'ADD',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
