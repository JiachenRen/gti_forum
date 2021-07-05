import 'package:gti_forum/model/post_stats.dart';
import 'package:gti_forum/model/user.dart';

class Post {
  String title;
  String content;
  User user;
  PostStats postStats;

  Post(
      {required this.title, required this.content, required this.user, required this.postStats});
}