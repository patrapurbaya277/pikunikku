import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/about/about_cubit.dart';
import 'package:pikunikku/pages/about/widgets/1about.dart';
import 'package:pikunikku/pages/about/widgets/2testimoni.dart';
import 'package:pikunikku/pages/about/widgets/3kontak.dart';
import 'package:pikunikku/pages/about/widgets/4FAQ.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  List<Widget> buildDot(int index, int dotCount) {
    List<Widget> _list = [];
    for (var i = 0; i < dotCount; i++) {
      _list.add(Container(
        margin: EdgeInsets.all(5),
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: i == index ? Colors.blue : Colors.white,
          shape: BoxShape.circle,
        ),
      ));
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return BlocBuilder<AboutCubit, AboutState>(builder: (context, state) {
      return Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 20, top: 30),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.8)
              ])),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      [
                        "Tentang Kami",
                        "Testimoni",
                        "Kontak",
                        "FAQ"
                      ][state.index!.toInt()],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              context.read<AboutCubit>().previousMenu();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: state.index == 0
                                  ? Colors.transparent
                                  : Colors.white,
                            )),
                        ...buildDot(state.index!.toInt(), state.maxMenu),
                        InkWell(
                          onTap: () {
                            context.read<AboutCubit>().nextMenu();
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: state.index == state.maxMenu - 1
                                ? Colors.transparent
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: InkWell(
                    onTap: () {
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                          overlays: [
                            SystemUiOverlay.top,
                            SystemUiOverlay.bottom
                          ]);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Kembali",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              foregroundDecoration:
                  BoxDecoration(color: Colors.black.withOpacity(0.7)),
              child: Image.asset(
                "assets/images/about-us.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: [
                    About(),
                    Testimonials(),
                    Contact(),
                    FAQ()
                  ][state.index!.toInt()]),
            ),
          ],
        ),
      );
    });
  }
}
