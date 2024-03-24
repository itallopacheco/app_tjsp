import 'package:flutter/material.dart';

class My_Tile extends StatelessWidget {
  final String imageURL;
  final Function()? onTap;
  const My_Tile({super.key, required this.imageURL, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffe7c87b), width: 2),
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xffeeeeee),
        ),
        child: Image.network(
          imageURL,
          height: 50,
        ),
      ),
    );
  }
}
