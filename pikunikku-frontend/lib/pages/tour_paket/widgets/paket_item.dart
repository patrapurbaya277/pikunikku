import 'package:flutter/material.dart';
import 'package:pikunikku/sources/model/paket.dart';

class PaketItem extends StatelessWidget {
  final Paket? paket;
  const PaketItem({Key? key, this.paket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xff00adef).withOpacity(0.2),
        borderRadius: BorderRadius.circular(7),
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                paket!.packageName.toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00adef)),
              ),
              SizedBox(
                height: 5,
              ),
              Text(paket!.packageDescription.toString(),
                  style: TextStyle(fontSize: 15)),
              SizedBox(height: 15),
              Text(
                "Rp " + paket!.packagePrice.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Pesan"),
          ),
        ],
      ),
    );
  }
}
