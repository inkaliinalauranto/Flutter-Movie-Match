import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _number++;
                });
              },
              child: const Icon(Icons.add)),
          SizedBox(
            width: 20.0,
          ),
          Text("$_number")
        ],
      ),
    );
  }
}
