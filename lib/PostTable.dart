import 'package:flutter/material.dart';
import 'Post.dart';
import 'main.dart';

class PostTable extends StatefulWidget {
  final List<Post> posts;

  PostTable(this.posts);

  @override
  _PostTableState createState() => _PostTableState();
}

class _PostTableState extends State<PostTable> {
  bool _isAscending = true;
  int _sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataTable and Charts'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChartPage(widget.posts),
                ),
              );
            },
          ),
        ],
      ),
      body: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _isAscending,
        columns: [
          DataColumn(
            label: Text('Title'),
            onSort: (columnIndex, ascending) {
              _sortColumn(columnIndex, ascending);
            },
          ),
          DataColumn(
            label: Row(
              children: [
                Text(''),
                IconButton(
                  icon: Icon(Icons.arrow_drop_up),
                  onPressed: () {
                  },
                ),
              ],
            ),
            onSort: (columnIndex, ascending) {
              _sortColumn(columnIndex, ascending);
            },
          ),
          DataColumn(
            label: Row(
              children: [
                Text(''),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                  },
                ),
              ],
            ),
            onSort: (columnIndex, ascending) {
              _sortColumn(columnIndex, ascending);
            },
          ),
        ],
        rows: widget.posts.map((post) {
          return DataRow(
            cells: [
              DataCell(Text(post.title)),
              DataCell(
                Row(
                  children: [
                    Text('${post.numUpVotes}'),
                    IconButton(
                      icon: Icon(Icons.arrow_upward),
                      onPressed: () {
                        setState(() {
                          post.numUpVotes++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              DataCell(
                Row(
                  children: [
                    Text('${post.numDownVotes}'),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: () {
                        setState(() {
                          post.numDownVotes++;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _sortColumn(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;

      widget.posts.sort((a, b) {
        if (ascending) {
          return _compareValues(a, b, columnIndex);
        } else {
          return _compareValues(b, a, columnIndex);
        }
      });
    });
  }

  int _compareValues(Post a, Post b, int columnIndex) {
    switch (columnIndex) {
      case 0:
        return a.title.compareTo(b.title);
      case 1:
        return a.numUpVotes.compareTo(b.numUpVotes);
      case 2:
        return a.numDownVotes.compareTo(b.numDownVotes);
      default:
        return 0;
    }
  }
}