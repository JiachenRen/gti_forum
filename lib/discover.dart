import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gti_forum/model/comment.dart';
import 'package:gti_forum/model/post.dart';
import 'package:gti_forum/model/post_stats.dart';
import 'package:gti_forum/model/user.dart';
import 'package:gti_forum/post_details.dart';

final _frank = User(username: 'Frank36');
final _zhou = User(username: 'ZhouXL');
final _scott = User(username: 'ScottWang');

final _ddl = Post(
    title: "I got my Driver's License!",
    tags: ["Driver's License"],
    content:
        "After a lengthy struggle, I finally managed to overcome all of the hurdles and got my hands on a driver's license, yay!",
    comments: [
      Comment(
          subComments: [],
          comment: 'Bro, I feel your pain! I just got mine yesterday.',
          user: User(username: 'Mark')),
      Comment(
          subComments: [],
          comment: 'Congrats!',
          user: User(username: 'Anderson'))
    ],
    user: _frank,
    postStats: PostStats(helpfulCount: 34));
final _visa = Post(
    title: "Need urgent help with Visa",
    tags: ["Visa", "COVID 19"],
    content:
        "During covid 19, I was forced to return home, but now I'm having trouble getting a new visa because US embassies are closed. What should I do, please help!",
    acceptedSolution: "I am in the same situation as you. "
        "My home country is China, and due to the recent rise in tensions with US, many embassies in China has suspended their services. "
        "That doesn't mean I had no way to renew my VISA, however. I heard that many of my friends who had the same problem were able to renew "
        "their visa by visiting the embassy in Singapore. I, on the other hand, got mine renewed in Canada last month. Just know that VISA can be issued "
        "by a third country that's not US, it doesn't have to be your home country.",
    comments: [
      Comment(
          subComments: [],
          comment:
          "Thanks everyone! Fortunately, the embassy reopened so I was able to renew my visa without any problems!",
          user: User(username: "ZhouXL")),
      Comment(
          subComments: [],
          comment:
              "I'm sorry to hear that, mate... that's why I stayed during the entire pandemic!",
          user: User(username: "Andrew64")),
      Comment(
        comment:
            'It depends on where your home country is at. PM me so I can help you.',
        user: User(username: 'Dio'),
        subComments: [
          Comment(
              subComments: [],
              comment:
                  "Yeah, I heard that China's situation is kind of grim, since they closed Chengdu's embassy and whatnot, but I dont' know about elsewhere",
              user: User(
                username: 'Tian',
              ))
        ],
      ),
      Comment(
          subComments: [],
          comment:
          "Same situation here! Didn't know you could go to any third country...",
          user: User(username: "Frank Lin")),
    ],
    user: _zhou,
    postStats: PostStats(helpfulCount: 126));
final _amazonIntern = Post(
    title: "How I got a software intern position at Amazon",
    tags: ["Intern", "Amazon"],
    content:
        "It's one of my biggest dream coming true - working at Amazon. Here's how I got the job.",
    comments: [
      Comment(
          subComments: [],
          comment: 'And, how did you get it?',
          user: User(username: 'Ann Christ')),
    ],
    user: _scott,
    postStats: PostStats(helpfulCount: 45));

List<_DiscoverTab> _tabs = [
  _DiscoverTab('Trending', [_visa, _amazonIntern, _ddl]),
  _DiscoverTab('Most Recent', [_ddl, _amazonIntern, _visa]),
  _DiscoverTab('Most Helpful', [_visa, _amazonIntern, _ddl])
];

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> with TickerProviderStateMixin {
  TabBar _buildTabBar() {
    return TabBar(
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
      tabs: _tabs.map((tab) {
        return Tab(text: tab.title);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Text('GTI Forum'),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            actions: _buildActions(),
            bottom: _buildTabBar(),
          ),
          body: TabBarView(
            children: _tabs.map((tab) {
              return _buildTab(tab);
            }).toList(),
          )),
    );
  }

  Widget _buildTab(_DiscoverTab tab) {
    return ListView.builder(
      itemCount: tab.posts.length,
      itemBuilder: (context, idx) {
        return _buildPost(context, tab.posts[idx]);
      },
    );
  }

  Widget _buildPost(BuildContext context, Post post) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PostDetails(post: post);
        }));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  post.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 4,
              ),
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
                          style: Theme.of(context).textTheme.overline,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                post.content,
                style: Theme.of(context).textTheme.caption,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
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

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          Feather.plus,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Create New Post'),
                  content: Text('Unimplemented'),
                );
              });
        },
      ),
    ];
  }
}

class _DiscoverTab {
  final String title;
  final List<Post> posts;

  _DiscoverTab(this.title, this.posts);
}
