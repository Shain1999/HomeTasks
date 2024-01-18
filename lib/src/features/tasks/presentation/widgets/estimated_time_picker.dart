import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DurationPickerWidget extends StatefulWidget {
  final Duration initialDuration;
  final String label;
  final void Function(Duration) onChange;

  const DurationPickerWidget({
    Key? key,
    required this.initialDuration,
    required this.label,
    required this.onChange,
  }) : super(key: key);

  @override
  _DurationPickerWidgetState createState() => _DurationPickerWidgetState();
}

class _DurationPickerWidgetState extends State<DurationPickerWidget> {
  late TextEditingController _controller;
  int selectedHours = 0;
  int selectedMinutes = 15;
  bool isError=false;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatDuration(widget.initialDuration));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(widget.label),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Gap(10),
                            Text("H:"),
                            Gap(1),
                            DropdownButton<int>(
                              value: selectedHours,
                              items: List.generate(25, (index) {
                                return DropdownMenuItem<int>(
                                  value: index,
                                  child: Text(index.toString()),
                                );
                              }),
                              onChanged: (value) {
                                setState(() {
                                  selectedHours = value!;

                                });
                              },
                            ),
                            Gap(10),
                            Text("m:"),
                            Gap(1),
                            SizedBox(height: 16),
                            DropdownButton<int>(
                              value: selectedMinutes,
                              items: List.generate(61, (index) {
                                return DropdownMenuItem<int>(
                                  value: index,
                                  child: Text(index.toString()),
                                );
                              }),
                              onChanged: (value) {
                                setState(() {
                                  selectedMinutes = value!;

                                });
                              },
                            ),
                            Gap(10),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Duration selectedDuration =
                                Duration(hours: selectedHours, minutes: selectedMinutes);
                                widget.onChange(selectedDuration);
                                _controller.text = _formatDuration(selectedDuration);
                                if(selectedDuration.inMilliseconds>0){
                                  setState(() {
                                    isError = false;
                                  });
                                  Navigator.of(context).pop();
                                }
                                else{
                                  setState(() {
                                    isError = true;
                                  });
                                }
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),

                          Text(
                            isError ? "Must have estimate time":"",
                            style: TextStyle(color: Colors.red),
                          ),

                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      controller: _controller,
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

String _formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  return 'H:$hours m:${minutes.toString().padLeft(2, '0')}';
}
