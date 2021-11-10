import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            hint: "Username",
          ),
          CustomTextField(
            hint: "Password",
          ),
          SizedBox(height: 25,),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              )),
                backgroundColor: MaterialStateProperty.all(Color(0xff00ADEF))),
            onPressed: () {},
            child: Container(
              width: 100,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                "Masuk",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? hint;
  const CustomTextField({Key? key, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        // height: 50,
        child: TextField(
          decoration: InputDecoration(
              // labelText: this.label,
              hintText: this.hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              )),
        ),
      ),
    );
  }
}
