import 'package:flutter/material.dart';

import '../../domain/comment_model.dart';

class CommentTile extends StatelessWidget {
  final CommentModel commentModel;
  const CommentTile({Key? key, required this.commentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text('User'),
      subtitle: Text(commentModel.commentText ?? ''),
    );
  }
}
