import 'package:gti_forum/model/comment.dart';
import 'package:gti_forum/model/post_stats.dart';
import 'package:gti_forum/model/user.dart';

class Post {
  String title;
  String content;
  User user;
  List<String> tags;
  List<Comment> comments;
  String? acceptedSolution;
  PostStats postStats;

  Post(
      {required this.tags,
        this.acceptedSolution,
      required this.title,
      required this.content,
      required this.user,
      required this.postStats,
      required this.comments});
}
