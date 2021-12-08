import 'package:flutter/material.dart';
import 'package:pikunikku/pages/register/widgets/register_field.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({ Key? key }) : super(key: key);
  static TextEditingController kotaController = TextEditingController();
  static TextEditingController provController = TextEditingController();
  static TextEditingController kodePosController = TextEditingController();
  static TextEditingController aLengkapController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegisterField(
          label: "Kota",
          controller: kotaController,
        ),
        RegisterField(
          label: "Provinsi",
          controller: provController,
        ),
        RegisterField(
          label: "Kode Pos",
          controller: kodePosController,
        ),
        RegisterField(
          label: "Alamat Lengkap",
          controller: aLengkapController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 15,
              ),
              Text(
                "Sebelumnya",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
              
            ],
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff00ADEF))),
          onPressed: () {},
        ),
            TextButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selanjutnya",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 15,
              ),
            ],
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff00ADEF))),
          onPressed: () {},
        ),
          ],
        )
      ],
    );
  }
}