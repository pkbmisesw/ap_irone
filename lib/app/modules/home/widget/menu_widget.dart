import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.value,
      required this.color1,
      required this.color2,
      this.fuction});
  final String image;
  final String title;
  final String value;
  final Color color1;
  final Color color2;
  final VoidCallback? fuction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: fuction,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color1, color2],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Image.asset(
                    image,
                    color: color1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tap to View",
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
