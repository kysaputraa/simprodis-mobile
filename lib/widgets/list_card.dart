import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  String title;
  String judul;
  String tanggal;
  String isi;
  ListCard({
    super.key,
    required this.title,
    required this.judul,
    required this.tanggal,
    required this.isi,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.green),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      tanggal,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                height: 2,
                thickness: 2,
                color: Colors.black45,
              ),
            ),
            FittedBox(
              child: Text(
                judul,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Text(
              isi,
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
