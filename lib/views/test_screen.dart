import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Button Loader Example')),
        body: ButtonLoaderExample(),
      ),
    );
  }
}

class ButtonLoaderExample extends StatefulWidget {
  @override
  _ButtonLoaderExampleState createState() => _ButtonLoaderExampleState();
}

class _ButtonLoaderExampleState extends State<ButtonLoaderExample> {
  bool _isLoading = false;

  void _onButtonClick() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: _isLoading ? 50 : 200, // Shrink width when loading
        height: 50, // Fixed height
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _isLoading
              ? SizedBox(
            key: ValueKey(1), // Unique key for AnimatedSwitcher
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : ElevatedButton(
            key: ValueKey(2), // Unique key for AnimatedSwitcher
            onPressed: _isLoading ? null : _onButtonClick,
            child: Text('Click Me'),
          ),
        ),
      ),
    );
  }
}
