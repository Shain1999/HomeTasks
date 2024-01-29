import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final void Function(List<String>)? onChangeHandler;

  const CommentWidget({Key? key, this.onChangeHandler}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class CommentOperationParams {
  late String newComment;
  late int editedIndex;

  CommentOperationParams({required this.newComment, required this.editedIndex});
}

class _CommentWidgetState extends State<CommentWidget> {
  List<String> comments = [];
  final TextEditingController _textEditingController = TextEditingController();
  bool _isEditing = false;
  late int _editedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _openCommentModal,
          child: Text('Add Comment'),
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(comments[index]),
              onTap: () => _editComment(CommentOperationParams(newComment: comments[index], editedIndex: index)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeComment(index),
              ),
            );
          },
        ),
      ],
    );
  }

  void _openCommentModal() {
    _textEditingController.clear();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter your comment',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _saveComment(CommentOperationParams(newComment: _textEditingController.text, editedIndex: -1)),
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveComment(CommentOperationParams params) {
    if (params.editedIndex != -1) {
      comments[params.editedIndex] = params.newComment;
    } else {
      setState(() {
        comments.add(params.newComment);
        widget.onChangeHandler!(comments);
      });
    }
    Navigator.pop(context);
  }

  void _editComment(CommentOperationParams params) {
    _textEditingController.text = params.newComment;
    _editedIndex = params.editedIndex;
    setState(() {
      _isEditing = true;
    });
    _openCommentModal();
  }

  void _removeComment(int index) {
    setState(() {
      comments.removeAt(index);
      widget.onChangeHandler!(comments);
    });
  }
}
