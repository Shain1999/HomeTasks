import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotesWidget extends StatefulWidget {
  final void Function(List<String>)? onChangeHandler;

  const NotesWidget({Key? key, this.onChangeHandler}) : super(key: key);

  @override
  _NotesWidgetState createState() => _NotesWidgetState();
}

class NotesOperationParams {
  late String newNote;
  late int editedIndex;

  NotesOperationParams({required this.newNote, required this.editedIndex});
}

class _NotesWidgetState extends State<NotesWidget> {
  List<String> notes = [];
  final TextEditingController _textEditingController = TextEditingController();
  bool _isEditing = false;
  late int _editedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Notes"),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              onPressed: _openNoteModal,
              label: Text("Add Note"),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]),
                  onTap: () => _editNote(NotesOperationParams(newNote: notes[index], editedIndex: index)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeNote(index),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  void _openNoteModal() {
    if(!_isEditing){
      _textEditingController.clear();
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Enter your note',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _saveNote(NotesOperationParams(newNote: _textEditingController.text, editedIndex: _isEditing?_editedIndex:-1)),
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveNote(NotesOperationParams params) {
    if (params.editedIndex != -1) {
      notes[params.editedIndex] = params.newNote;
      widget.onChangeHandler!(notes);
    } else {
      setState(() {
        notes.add(params.newNote);
        widget.onChangeHandler!(notes);
      });
    }
    if(_isEditing){
      setState(() {
        _isEditing = false;
      });
    }
    Navigator.pop(context);
  }

  void _editNote(NotesOperationParams params) {
    _textEditingController.text = params.newNote;
    _editedIndex = params.editedIndex;
    setState(() {
      _isEditing = true;
    });
    _openNoteModal();
  }

  void _removeNote(int index) {
    setState(() {
      notes.removeAt(index);
      widget.onChangeHandler!(notes);
    });
  }
}
