import 'package:flutter/material.dart';
import 'package:pikunikku/sources/model/faq.dart';

class FAQItem extends StatelessWidget {
  final FAQClass? faq;
  const FAQItem({Key? key, this.faq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue,
                height: 40,
                width: 3,
              ),
              SizedBox(width: 10),
              Text(
                "Q",
                style: TextStyle(
                  color: Color(0xff00adef),
                  fontSize: 30,
              
                ),
                // textAlign: TextAlignVertical.top,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  faq!.question.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                height: 40,
                width: 3,
              ),
              SizedBox(width: 10),
              Text(
                "A",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  faq!.answer.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          
        ],
      ),
    );
  }
}
