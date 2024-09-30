// import 'package:flutter/material.dart';
//
// class ButtonWithAnimation extends StatefulWidget {
//   bool isAnimating = false;
//   final double height;
//   final double width;
//   final String title;
//   void Function()? onPressed;
//
//   ButtonWithAnimation({super.key,  required this.height, required this.width, required this.title, required this.onPressed, required this.isAnimating});
//   @override
//   ButtonWithAnimationState createState() => ButtonWithAnimationState();
// }
//
// class ButtonWithAnimationState extends State<ButtonWithAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 1),
//       vsync: this,
//     );
//
//     // Tween to scale down from original size to a smaller size
//     _animation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _animateButton() {
//     widget.onPressed;
//     setState(() {
//       widget.isAnimating = true;
//     });
//     _controller.forward().then((_) {
//       // After animation completes, you can show the CircularProgressIndicator
//       setState(() {
//         widget.isAnimating = false; // Resetting state for UI updates
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Button Animation to Progress Bar'),
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Circular Progress Indicator
//           if (!widget.isAnimating) CircularProgressIndicator(),
//           // Animated button
//           ScaleTransition(
//             scale: Tween<double>(begin: 1.0, end: 0.0).animate(
//               CurvedAnimation(
//                 parent: _controller,
//                 curve: Curves.easeInOut,
//               ),
//             ),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 fixedSize: Size(widget.width, widget.height),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12), // Rectangular button with curved edges
//                 ),
//                 // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//               ),
//               onPressed: widget.isAnimating ? null : _animateButton,
//               child: Text(widget.title),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(home: TestScreen()));
// }
//
// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//
//   bool isAnimating = false;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ButtonWithAnimation(height: 60, width: 200, title: "Show Animation", onPressed: () {
//         setState(() {
//           isAnimating = true;
//         });
//         Future.delayed(Duration(seconds: 3),(){
//           setState(() {
//             isAnimating = false;
//           });
//         });
//       }, isAnimating: isAnimating,),
//     );
//   }
// }
//

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Multiple GridViews with Scroll')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // First GridView with a fixed height
              SizedBox(
                height: 150, // Fixed height
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(
                          'Grid 1 - Item $index',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Second GridView with a fixed height
              SizedBox(
                height: 150, // Fixed height
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          'Grid 2 - Item $index',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

