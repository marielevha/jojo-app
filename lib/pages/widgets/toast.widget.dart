import 'package:flutter/material.dart';

class BasicToast extends StatelessWidget {
  final String message;
  final Color color;
  final IconData icon;

  const BasicToast({super.key,
    required this.message,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(
            width: 12.0,
          ),
          Container(
            child: Text(
              '$message',
              style: TextStyle(
                fontFamily: 'Muli',
                fontSize: 16,
                fontWeight: FontWeight.w300
              ),
            ),
            width: width * 0.6,
          ),
        ],
      ),
    );
  }
}
