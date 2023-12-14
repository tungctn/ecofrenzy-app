import 'package:flutter/material.dart';
import 'package:flutter_app/provider/actions/auth.action.dart';
import 'package:flutter_app/provider/actions/post.action.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/services/post.service.dart';
import 'package:flutter_app/utils/color.dart';
import 'package:flutter_app/utils/icon.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class FeedScreen extends StatefulWidget {
  static const String routeName = '/feed';

  const FeedScreen({super.key});

  @override
  FeedScreenState createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {
  bool _isLoading = false;
  final postNotifier = PostNotifier();
  TextEditingController commentController = TextEditingController();
  final authNotifier = AuthNotifier();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadFeed();
  }

  void loadFeed() async {
    await AuthActions.checkAuth(context.read<AuthNotifier>());
    await PostActions.fetchPost(context.read<PostNotifier>());
    if (mounted) {
      // dynamic listLikes = postNotifier.posts.map((e) => e,)
      setState(() {
        _isLoading = false;
      });
    }
  }

  void addComment(String comment) async {}

  String formatDay(DateTime createdAt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(createdAt.year, createdAt.month, createdAt.day);

    if (aDate == today) {
      return 'Today';
    } else if (aDate == yesterday) {
      return 'Yesterday';
    } else {
      final daysDifference = now.difference(createdAt).inDays;
      return '$daysDifference days ago';
    }
  }

  void _showCommentsSheet(comments, postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final List listComment = comments;
        return Consumer<AuthNotifier>(
          builder: (context, notifier, _) {
            return Container(
              height: MediaQuery.of(context).size.height - 20,
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Ridley Grotesk Bold"),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listComment.length,
                      itemBuilder: (context, index) {
                        final comment = listComment[index];
                        return ListTile(
                            subtitle: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  comment['user']['image'].toString()),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xffDCDCDC),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        comment['user']['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Text(
                                        comment['content'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )))
                          ],
                        ));
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "Ridley Grotesk Regular"),
                              controller: commentController,
                              decoration: const InputDecoration(
                                hintText: 'Add a comment...',
                                border: InputBorder.none,
                              )),
                        )),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            print(commentController.text);
                            listComment.add({
                              'user': {
                                'name': notifier.user['name'],
                                'image': notifier.user['image'],
                              },
                              'content': commentController.text
                            });
                            PostActions.commentPost(
                                PostNotifier(), postId, commentController.text);
                            FocusScope.of(context).unfocus();
                            commentController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
            // bool isLiked =
            //     post['likes'].contains(post['user']['id']) ? true : false;
            // post["isLiked"] = isLiked;
            DateTime createdAt = DateTime.parse(post['createdAt']);
            String formattedDate = DateFormat('kk:mm').format(createdAt);

            // formattedDay is yesterday or today or 2 days ago and so on
            String formattedDay = formatDay(createdAt);
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
                        title: Row(
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
                                  formattedDay,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  formattedDate,
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
                      child: InkWell(
                        onTap: () {
                          print(post['liked']);
                          print(post);
                          notifier.likePost(post['_id']);
                          PostService().likePost(post['_id']);
                        },
                        child: !post["liked"] ? tymIcon : heartIcon,
                      ),
                    ),
                    Positioned(
                      bottom: 13,
                      left: 70,
                      child: InkWell(
                          onTap: () {
                            // final List comments = [
                            //   {'username': 'User1', 'comment': 'Nice post!'},
                            //   {
                            //     'username': 'User2',
                            //     'comment':
                            //         'I love this! I kkkkkkkkkkkkkkkkkkkkkkdkalsdkmalsdalkskadaldmskadmlsadmksa'
                            //   },
                            // ];
                            final List comments = post['comments'];
                            _showCommentsSheet(comments, post['_id']);
                            print('comment');
                          },
                          child: commentIcon),
                    ),
                  ],
                ));
          },
        ));
      },
    );
  }
}
