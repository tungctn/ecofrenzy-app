import 'package:flutter/material.dart';
import 'package:flutter_app/provider/actions/post.action.dart';
import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/utils/color.dart';
import 'package:flutter_app/utils/icon.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  static const String routeName = '/feed';

  const FeedScreen({super.key});

  @override
  FeedScreenState createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadFeed();
  }

  void loadFeed() async {
    await PostActions.fetchChallenges(context.read<PostNotifier>());
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostNotifier>(
      builder: (context, notifier, _) {
        if (_isLoading) {
          return const Loading();
        }
        return Scaffold(
            body: ListView.builder(
          itemCount: notifier.posts.length,
          itemBuilder: (context, index) {
            final post = notifier.posts[index];
            return Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
                // padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 144, 138, 138),
                      blurRadius: 20.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    ListTile(
                        title: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                      "assets/images/avatar.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    post['user']['name'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Yesterday",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "10:49",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 3, bottom: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(15),
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0xFFBE61F8),
                                                  blurRadius: 20.0,
                                                  offset: Offset(0, 5),
                                                ),
                                              ],
                                              // color: getGradientColor(challenge)[0],
                                              color: getColorByCategory(
                                                  post['challenge']
                                                      ['category']),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          // AssetImage(getIcon(challenge)),
                                                          AssetImage(getIconByCategory(
                                                              post['challenge'][
                                                                  'category'])),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          // challenge.name,
                                                          post['challenge']
                                                              ['name'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          // challenge.impact,
                                                          post['challenge']
                                                              ['caption'],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                              ],
                                            )),
                                      ),
                                    ]),
                                  ],
                                )),
                            SizedBox(
                              width: double.infinity,
                              height: 250,
                              child: Image.network(
                                post['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: 10,
                      left: 20,
                      child: tymIcon,
                    ),
                    Positioned(
                      bottom: 13,
                      left: 70,
                      child: commentIcon,
                    ),
                  ],
                ));
          },
        ));
      },
    );
  }
}
