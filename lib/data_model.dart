class PostModel {
  List<Post>? posts;
  int? total;
  int? skip;
  int? limit;

  PostModel({this.posts, this.total, this.skip, this.limit});

  factory PostModel.fromjson(Map json) {
    return PostModel(
      posts: Post.fromjson(json['Post']),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}

class Post {
  int? Id;
  String? title;
  String? body;
  List<String>? tags;
  final Reactions? reactions;
  int? views;
  int? userId;

  Post(
      {this.Id,
      this.title,
      this.body,
      this.tags,
      this.reactions,
      this.views,
      this.userId});

  factory Post.fromjson(Map json) {
    return Post(
      Id: json['Id'],
      title: json['title'],
      tags: json['tags'],
      reactions: Reactions.fromjson(json['Reactions']),
      views: json['views'],
      userId: json['userId'],
    );
  }
}

class Reactions {
  int? likes;
  int? dislikes;

  Reactions({this.likes, this.dislikes});

  factory Reactions.fromjson(Map json) {
    return Reactions(
      likes: json['likes'],
      dislikes: json['dislikes'],
    );
  }
}


