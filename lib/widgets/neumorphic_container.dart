import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double depth;
  final Color color;

  const NeumorphicContainer({super.key, 
    required this.child,
    this.borderRadius = 12.0,
    this.depth = 8.0,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(depth, depth),
            blurRadius: depth,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-depth, -depth),
            blurRadius: depth,
          ),
        ],
      ),
      child: child,
    );
  }
}
