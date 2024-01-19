import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'Post.dart';
import 'PostTable.dart';


void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final List<Post> posts = Post.generateData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Network',
      home: PostTable(posts),
    );
  }
}




class ChartPage extends StatelessWidget {
  final List<Post> posts;

  ChartPage(this.posts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Stats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: charts.BarChart(
                  _createSeries(),
                  animate: true,
                  vertical: false, // Set to false for horizontal orientation
                  barGroupingType: charts.BarGroupingType.grouped,
                  behaviors: [
                    charts.SeriesLegend(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<charts.Series<Post, String>> _createSeries() {
    return [
      charts.Series(
        id: 'UpVotes',
        data: posts,
        domainFn: (Post post, _) => post.title,
        measureFn: (Post post, _) => post.numUpVotes,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        displayName: 'UpVotes',
      ),
      charts.Series(
        id: 'DownVotes',
        data: posts,
        domainFn: (Post post, _) => post.title,
        measureFn: (Post post, _) => post.numDownVotes,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        displayName: 'DownVotes',
      ),
    ];
  }
}