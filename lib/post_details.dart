import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gti_forum/model/comment.dart';
import 'package:gti_forum/model/post.dart';

class PostDetails extends StatelessWidget {
  final Post post;

  const PostDetails({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
        actions: [
          IconButton(icon: Icon(Feather.heart), onPressed: () {},)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostDetails(context),
              _buildSolution(context),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange)),
                      onPressed: () {},
                      child: Text('Needs Update'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Helpful'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Replies',
                style: Theme.of(context).textTheme.headline6,
              ),
              _buildComments(context, post.comments, 0)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSolution(BuildContext context) {
    var content = post.acceptedSolution ??
        "This post does not yet have an accepted solution.";
    var solved = post.acceptedSolution != null;
    var color = solved ? Colors.green : Colors.orange;

    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(8),
      color: color.withOpacity(0.2),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                solved ? Feather.check_circle : Feather.alert_triangle,
                color: color,
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                solved ? 'Solved' : 'Unsolved',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: color),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(content)
        ],
      ),
    );
  }

  Widget _buildPostDetails(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 4),
              Wrap(
                spacing: 4,
                children: [
                  ...post.tags.map((e) => Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        child: Text(
                          e,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(post.content),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    'by ${post.user.username}',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  Spacer(),
                  Icon(
                    Feather.thumbs_up,
                    size: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('${post.postStats.helpfulCount}')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComments(
      BuildContext context, List<Comment> comments, int level) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...comments.map(
          (e) => Padding(
            padding: EdgeInsets.only(left: level * 8),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.user.username,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(e.comment),
                    if (e.subComments.isNotEmpty)
                      _buildComments(context, e.subComments, level + 1)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
