import 'package:flutter_app/provider/notifiers/activity.notifier.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/provider/notifiers/profile.notifier.dart';
import 'package:flutter_app/provider/notifiers/user.notifier.dart';
import 'package:flutter_app/views/layouts/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/screens/auth/sign_in.screen.dart';
import 'package:flutter_app/views/screens/auth/sign_up.screen.dart';
import 'package:flutter_app/views/screens/profile.screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:flutter_app/provider/store.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Store store = Store();
  bool _isAuthChecked = false;
  @override
  void initState() {
    super.initState();
    _initCheckAuth();
  }

  Future<void> _initCheckAuth() async {
    await store.authNotifier.checkAuth();
    if (mounted) {
      setState(() {
        _isAuthChecked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthChecked) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ChallengeNotifier>.value(
              value: store.challengeNotifier),
          ChangeNotifierProvider<PostNotifier>.value(value: store.postNotifier),
          ChangeNotifierProvider<AuthNotifier>.value(value: store.authNotifier),
          ChangeNotifierProvider<ProfileNotifier>.value(
              value: store.profileNotifier),
          ChangeNotifierProvider<ActivityNotifier>.value(
              value: store.activityNotifier),
          ChangeNotifierProvider<UserNotifier>.value(value: store.userNotifier),
        ],
        child: Consumer<AuthNotifier>(builder: (context, notifier, _) {
          return MaterialApp(
            initialRoute: notifier.isLogged ? "/" : "/sign-in",
            routes: {
              "/profile": (context) => const ProfileScreen(),
              "/sign-in": (context) => const SignInScreen(),
              "/sign-up": (context) => const SignUpScreen(),
              "/": (context) => const Navigation(),
            },
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: 'Ridley Grotesk Regular',
                  ),
            ),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
