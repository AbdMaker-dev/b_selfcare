import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';

class SubscriberAvatar extends StatelessWidget {
  final Color colorAvatar;
  final double size;
  final String initial;

  const SubscriberAvatar({
    super.key,
    required this.colorAvatar,
    required this.initial,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.rw,
      height: size.rh,
      decoration: BoxDecoration(
        color: colorAvatar.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize: size * 0.32.rsp,
            fontWeight: FontWeight.w700,
            color: colorAvatar,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}