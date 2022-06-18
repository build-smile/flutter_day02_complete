import 'package:flutter/material.dart';

import '../models/Feed.dart';
import '../services/FeedAPI.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FeedService().getFeed(),
        builder: (BuildContext context, AsyncSnapshot<List<Feed>> snapshot) {
          if (snapshot.hasData) {
            List<Feed> feeds = snapshot.data!;
            return ListView.builder(
                itemCount: feeds.length,
                itemBuilder: (BuildContext context, int i) {
                  Feed feed = feeds[i];
                  print(feed.title);
                  return ListTile(
                    title: Text('${feed.title}'),
                    subtitle: Text('${feed.body}'),
                    leading: Icon(Icons.post_add),
                    trailing: Text('${feed.userId}'),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
