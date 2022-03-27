

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/about/about_cubit.dart';
import 'package:pikunikku/pages/about/widgets/testimoni_item.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:url_launcher/url_launcher.dart';

class Testimonials extends StatelessWidget {
  const Testimonials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutState>(builder: (context, state) {
      return SizedBox(
        height: MediaQuery.of(context).size.height + 100,
        child: Column(
          // children: state.listTestimoni!=null?state.listTestimoni!.map((e) => TestimoniItem(testimoni: e,)).toList():[SizedBox()],
          children: [
            ...state.listTestimoni != null
                ? state.listTestimoni!
                    .map((e) => TestimoniItem(
                          testimoni: e,
                        ))
                    .toList()
                : [SizedBox()],
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                const url = URL.moreTestimoni;
      
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(
                "Lihat Selengkapnya",
                style: TextStyle(
                  color: Color(0xff00adef).withOpacity(0.8),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
