import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gti_forum/model/post.dart';
import 'package:gti_forum/model/post_stats.dart';
import 'package:gti_forum/model/user.dart';

final _frank = User(username: 'Frank36');
final _zhou = User(username: 'ZhouXL');
final _scott = User(username: 'ScottWang');

final _ddl = Post(
    title: "I got my Driver's License!",
    content: "After a lengthy struggle, I finally managed to overcome all of the hurdles and got my hands on a driver's license, yay!",
    user:  _frank, postStats: PostStats(helpfulCount: 34));
final _visa = Post(
    title: "Need urgent help with Visa",
    content: "During covid 19, I was forced to return home, but now I'm having trouble getting a new visa because US embassies are closed. What should I do, please help!",
    user:  _zhou, postStats: PostStats(helpfulCount: 126));
final _amazonIntern = Post(
    title: "How I got a software intern position at Amazon",
    content: "It's one of my biggest dream coming true - working at Amazon. Here's how I got the job.",
    user:  _scott, postStats: PostStats(helpfulCount: 45));

List<_DiscoverTab> _tabs = [
  _DiscoverTab('Trending', [
    _visa, _amazonIntern, _ddl
  ]),
  _DiscoverTab('Most Recent', [
    _ddl, _amazonIntern, _visa
  ]),
  _DiscoverTab('Most Helpful', [
    _visa, _amazonIntern, _ddl
  ])
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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                post.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 8,),
            Text(
              post.content,
              style: Theme.of(context).textTheme.caption,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text(
                  'by ${post.user.username}',
                  style: Theme.of(context).textTheme.overline,
                ),
                Spacer(),
                Icon(Feather.thumbs_up,size: 16,),
                SizedBox(width: 4,),
                Align(
                  alignment: Alignment.bottomLeft,
                    child: Text('${post.postStats.helpfulCount}')),
              ],
            )
          ],
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
