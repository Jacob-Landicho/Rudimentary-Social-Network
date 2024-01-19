class Post {
  String title;
  int numUpVotes;
  int numDownVotes;

  Post(this.title, this.numUpVotes, this.numDownVotes);

  static List<Post> generateData() {
    return List.generate(
      5,
          (index) => Post(
        'Sample Post ${index + 1}',
        ((index + 1) * 2).clamp(0, 6), // Limit the upper limit of upvotes to 6
        (index).clamp(0, 6), // Limit the upper limit of downvotes to 6
      ),
    );
  }
}