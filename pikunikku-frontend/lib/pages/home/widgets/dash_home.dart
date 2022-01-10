import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
import 'package:pikunikku/main.dart';

class DashHome extends StatelessWidget {
  const DashHome({Key? key}) : super(key: key);

  showImage(String src) {
    try {
      if (src != "null") {
        return NetworkImage(
            "https://beta.pikunikku.id/assets/images/profil_member/" + src);
      }
      return AssetImage("assets/images/user_default.png");
    } catch (e) {
      return NetworkImage(
          "https://pikunikku.id/assets/images/profil_member/" + src);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return SizedBox(
        height: 250,
        child: Stack(
          children: [
            SizedBox(
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.srcOver),
                  child: Image.asset(
                    "assets/images/slider.jpg",
                    fit: BoxFit.cover,
                  )),
              height: 250,
            ),
            Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  color: Color(0xff00ADEF),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Pikupoin: " +
                                    state.user!.pikunikkuPoint.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              // "Kamis, 23 September 2021",
                              DateFormat("EEEE, dd MMMM yyyy")
                                  .format(DateTime.now()),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Selamat Datang, ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 27)),
                            Text(state.user!.nama.capitalizeEachWord(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            image: DecorationImage(
                              image: showImage(state.user!.picture),
                              fit: BoxFit.cover,
                              onError:
                                  (Object? exception, StackTrace? stackTrace) {
                                print(exception);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
