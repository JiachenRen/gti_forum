import 'package:gti_forum/model/user.dart';

class Comment {
  final String comment;
  final List<Comment> subComments;
  final User user;

  Comment({required this.subComments, required this.comment, required this.user});
}