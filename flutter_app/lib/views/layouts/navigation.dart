import 'package:flutter/material.dart';
import 'package:flutter_app/provider/actions/auth.action.dart';
import 'package:flutter_app/provider/actions/challenge.action.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:flutter_app/utils/icon.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:flutter_app/views/screens/challenge.screen.dart';
import 'package:flutter_app/views/screens/challenge_detector.screen.dart';
import 'package:flutter_app/views/screens/feed.screen.dart';
import 'package:flutter_app/views/screens/friend.screen.dart';
import 'package:flutter_app/views/screens/voucher.screen.dart';
import 'package:flutter_app/views/screens/leaderboard.screen.dart';
import 'package:flutter_app/views/screens/learn.screen.dart';
import 'package:flutter_app/views/screens/auth/sign_in.screen.dart';
import 'package:flutter_app/views/screens/auth/sign_up.screen.dart';
import 'package:flutter_app/views/screens/auth/forgot_password.screen.dart';
import 'package:flutter_app/views/screens/profile.screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  bool _isPicked = false;
  bool _isLoading = false;
  // final authNotifier = AuthNotifier();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPage() {
    if (_selectedIndex == 0) {
      return const ChallengeScreen();
    } else if (_selectedIndex == 1) {
      return const FeedScreen();
    } else if (_selectedIndex == 2) {
      return const LeaderBoardScreen();
    } else if (_selectedIndex == 3) {
      return const VoucherScreen();
    }

    return const LearnScreen();
  }

  Widget _buildPagePicker() {
    if (_selectedIndex == 0) {
      return const ChallengeScreen();
    } else if (_selectedIndex == 1) {
      return const FeedScreen();
    } else if (_selectedIndex == 3) {
      return const VoucherScreen();
    }
    // else if (_selectedIndex == 4) {
    //   return const VoucherScreen();
    // }
    return const LearnScreen();
  }

  String _titleAppBar() {
    if (_selectedIndex == 0) {
      return "Thử thách";
    } else if (_selectedIndex == 1) {
      return "Bảng tin";
    } else if (_selectedIndex == 2) {
      return "Bảng xếp hạng";
    } else if (_selectedIndex == 3) {
      return "Mã giảm giá";
    }

    return "Today Challenge";
  }

  String _titleAppBarPicker() {
    if (_selectedIndex == 0) {
      return "Thử thách";
    } else if (_selectedIndex == 1) {
      return "Bảng tin";
    } else if (_selectedIndex == 3) {
      return "Bảng xếp hạng";
    } else if (_selectedIndex == 4) {
      return "Bạn bè";
    }
    return "Today Challenge";
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadChallenges();
  }

  void loadChallenges() async {
    await ChallengeActions.fetchChallenges(context.read<ChallengeNotifier>());
    // ignore: use_build_context_synchronously
    await AuthActions.checkAuth(context.read<AuthNotifier>());
    if (mounted) {
      bool isPicked = ChallengeNotifier()
          .challenges
          .any((e) => e.status == "Picked" || e.status == "Pending");
      setState(() {
        _isPicked = isPicked;
        _isLoading = false;
      });
    }
  }

  void handleProfile() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeNotifier>(builder: (context, notifier, _) {
      return Consumer<AuthNotifier>(builder: (context, authNotifier, _) {
        if (_isLoading) {
          return const Scaffold(body: Loading());
        }
        bool isPicked = notifier.challenges
            .any((e) => e.status == "Picked" || e.status == "Pending");
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FriendScreen()));
                },
                icon: const Icon(Icons.supervisor_account)),
            title: Text(
              isPicked ? _titleAppBarPicker() : _titleAppBar(),
              style: const TextStyle(
                  fontFamily: "Ridley Grotesk Bold", fontSize: 25),
            ),
            actions: [
              IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(authNotifier.user['image']),
                  radius:
                      20, // Bạn có thể điều chỉnh radius để thay đổi kích thước
                ),
                onPressed: () {
                  handleProfile();
                },
              ),
            ],
          ),
          body: isPicked ? _buildPagePicker() : _buildPage(),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: _buildBottomNavigationBarItems(notifier),
                currentIndex: _selectedIndex,
                selectedItemColor: Color(int.parse('FF68D69D', radix: 16)),
                onTap: _onItemTapped,
              ),
            ),
          ),
        );
      });
    });
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      ChallengeNotifier notifier) {
    List<BottomNavigationBarItem> items = [];

    items.add(const BottomNavigationBarItem(
      icon: SizedBox(
        height: 30,
        width: 30,
        child: Icon(FontAwesomeIcons.fire),
      ),
      label: 'Challenge',
    ));

    items.add(const BottomNavigationBarItem(
      icon: SizedBox(
        height: 30,
        width: 30,
        child: Icon(FontAwesomeIcons.compass),
      ),
      label: 'Feed',
    ));
    bool isPicked = notifier.challenges
        .any((e) => e.status == "Picked" || e.status == "Pending");
    if (isPicked) {
      items.add(BottomNavigationBarItem(
        icon: SizedBox(
          height: 80,
          width: 80,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF61F4BD),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.black87,
                size: 45,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChallengeDetectorView()));
              },
            ),
          ),
        ),
        label: '',
      ));
      // if (_selectedIndex == 3 && isPicked) {
      //   _selectedIndex = 2;
      // } else if (_selectedIndex == 4 && isPicked) {
      //   _selectedIndex = 3;
      // }
    }
    // else {
    //   if (_selectedIndex == 3) {
    //     _selectedIndex = 2;
    //   } else if (_selectedIndex == 4) {
    //     _selectedIndex = 3;
    //   }
    // }

    items.add(const BottomNavigationBarItem(
      icon:
          SizedBox(height: 30, width: 30, child: Icon(FontAwesomeIcons.trophy)),
      label: 'Leaderboard',
    ));

    items.add(BottomNavigationBarItem(
      icon:
          SizedBox(height: 30, width: 30, child: Icon(FontAwesomeIcons.ticket)),
      label: 'Mã giảm giá',
    ));

    return items;
  }
}
