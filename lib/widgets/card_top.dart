import 'package:flutter/material.dart';

class CardTop extends StatelessWidget {
  Color color;
  String judul;
  final Function() onTap;

  CardTop(
      {super.key,
      required this.color,
      required this.onTap,
      required this.judul});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 40, top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          width: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.article,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 50.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text(
                judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
