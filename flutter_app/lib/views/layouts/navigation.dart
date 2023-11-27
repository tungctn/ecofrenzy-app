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
import 'package:flutter_app/views/screens/incentives.screen.dart';
import 'package:flutter_app/views/screens/leaderboard.screen.dart';
import 'package:flutter_app/views/screens/learn.screen.dart';
import 'package:flutter_app/views/screens/auth/sign_in.screen.dart';
import 'package:flutter_app/views/screens/auth/sign_up.screen.dart';
import 'package:flutter_app/views/screens/auth/forgot_password.screen.dart';
import 'package:flutter_app/views/screens/profile.screen.dart';
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
    // switch (_selectedIndex) {
    //   case 0:
    //     return const ChallengeScreen();
    //   case 1:
    //     return const FeedScreen();
    //   case 2:
    //     return const LeaderBoardScreen();
    //   case 3:
    //   if (!isPicked) {
    //     return const FriendScreen();
    //   }
    //   return const LearnScreen();
    //   case 4:
    //     return const LearnScreen();
    //   default:
    //     return const ChallengeScreen();
    // }
    print(ChallengeNotifier().challenges.length);
    if (_selectedIndex == 0) {
      return const ChallengeScreen();
    } else if (_selectedIndex == 1) {
      return const FeedScreen();
    } else if (_selectedIndex == 2) {
      return const LeaderBoardScreen();
    } else if (_selectedIndex == 3) {
      print(_isPicked);
      return const FriendScreen();
    } else if (_selectedIndex == 4) {
      return const FriendScreen();
    }
    return const LearnScreen();
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
            leading: const Icon(Icons.supervisor_account),
            title: Text(
              _selectedIndex == 0
                  ? "Today Challenge"
                  : _selectedIndex == 1
                      ? "Feed"
                      : _selectedIndex == 2
                          ? "Leaderboard"
                          : _selectedIndex == 3
                              ? "Your Friends"
                              : "Learn",
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
          body: _buildPage(),
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

    items.add(BottomNavigationBarItem(
      icon: SizedBox(
        height: 30,
        width: 30,
        child: _selectedIndex == 0 ? incentivesIconSelect : incentivesIcon,
      ),
      label: 'Challenge',
    ));

    items.add(BottomNavigationBarItem(
      icon: SizedBox(
        height: 30,
        width: 30,
        child: _selectedIndex == 1 ? feedIconSelect : feedIcon,
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
      if (_selectedIndex == 3) {
        _selectedIndex = 2;
      } else if (_selectedIndex == 4) {
        _selectedIndex = 3;
      }
    }
    // else {
    //   if (_selectedIndex == 3) {
    //     _selectedIndex = 2;
    //   } else if (_selectedIndex == 4) {
    //     _selectedIndex = 3;
    //   }
    // }

    items.add(BottomNavigationBarItem(
      icon: SizedBox(
        height: 30,
        width: 30,
        child: _selectedIndex == (isPicked ? 3 : 2)
            ? leaderboardIconSelect
            : leaderboardIcon,
      ),
      label: 'Leaderboard',
    ));

    items.add(BottomNavigationBarItem(
      icon: SizedBox(
        height: 30,
        width: 30,
        child:
            _selectedIndex == (isPicked ? 4 : 3) ? learnIconSelect : learnIcon,
      ),
      label: 'Friends',
    ));

    return items;
  }
}
