import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/about/about_cubit.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';
// import 'package:intl/intl.dart';
// import 'package:pikunikku/cubit/login/login_cubit.dart';
// import 'package:pikunikku/cubit/main/main_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
import 'package:pikunikku/pages/about/screens/about.dart';
import 'package:pikunikku/pages/profile/screen/book_status.dart';
import 'package:pikunikku/pages/profile/screen/change_password.dart';
import 'package:pikunikku/pages/profile/screen/change_profile.dart';
import 'package:pikunikku/pages/profile/widgets/menu_item.dart';
// import 'package:pikunikku/pages/login/screen/login_page.dart';
import 'package:pikunikku/sources/api/url.dart';
// import 'package:provider/src/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(
                              URL.imageProfile + state.user!.picture),
                          fit: BoxFit.fitHeight),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          state.user!.nama,
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: state.user!.email + "  ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            TextSpan(
                              text:
                                  "(${state.user!.isVerified == true ? "Verified" : "Not Verified"})",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: (state.user!.isVerified == true
                                          ? Colors.green
                                          : Colors.red)
                                      .withOpacity(0.5)),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  TextButton(
                    child: Icon(
                      Icons.mode_edit_outline_rounded,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      context.read<EditCubit>().init(state.user!);
                      context.read<EditCubit>().initLocation();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ChangeProfile()));
                    },
                  ),
                ],
              ),
              Divider(),
              // MenuItem(
              //   label: "Ganti Email",
              //   icon: Icon(
              //     Icons.email,
              //     size: 20,
              //     color: Colors.black,
              //   ),
              //   onTap: () {
              //     context.read<EditCubit>().init(state.user!);
              //     Navigator.of(context).push(MaterialPageRoute(
              //             builder: (BuildContext context) => ChangeEmail()));
              //   },
              // ),
              MenuItem(
                icon: Icon(
                  Icons.vpn_key,
                  size: 20,
                  color: Colors.black,
                ),
                label: "Ganti Password",
                onTap: () {
                  context.read<EditCubit>().initPassword();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ChangePassword()));
                },
              ),
              Divider(),
              MenuItem(
                label: "Status Pemesanan",
                icon: Icon(Icons.event_note, size: 20, color: Colors.black),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>BookStatus()));
                },
              ),
              Divider(),
              MenuItem(
                  icon: Icon(Icons.info, size: 20, color: Colors.black),
                  label: "Tentang Aplikasi",
                  onTap: () {
                    context.read<AboutCubit>().init();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AboutPage()));
                  }),
              Divider(),
              Container(
                child: TextButton(
                  onPressed: () {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                      systemNavigationBarDividerColor: Colors.transparent,
                      systemNavigationBarColor: Colors.black,
                      systemNavigationBarIconBrightness: Brightness.light,
                    ));
                    context.read<UserCubit>().logout(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 20),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              // Divider(height:40),
              // Text("Nama :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
              // Text(state.user!.nama, style: TextStyle(fontSize: 16),),
              // SizedBox(height: 20),
              // Text("Tanggal Lahir :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
              // Text(DateFormat("dd MMMM yyyy").format(state.user!.tglLahir), style: TextStyle(fontSize: 16),),
              // SizedBox(height: 20),
              // Text("Email :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
              // Text(state.user!.email, style: TextStyle(fontSize: 16),),
              // SizedBox(height: 20),
              // Text("Nomor Handphone :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
              // Text(state.user!.noHp, style: TextStyle(fontSize: 16),),
              // SizedBox(height: 20),
              // Text("Kota :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
              // Text(state.user!.kota, style: TextStyle(fontSize: 16),),
              // SizedBox(height: 20),
              // Text("Provinsi :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
              // Text(state.user!.provinsi,style: TextStyle(fontSize: 16),),
              // SizedBox(height: 20),
              // Text("Alamat :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
              // Text(state.user!.alamat,style: TextStyle(fontSize: 16),),
              // SizedBox(height: 20),
              // Text("Kode Pos :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
              // Text(state.user!.kodePos,style: TextStyle(fontSize: 16),),
            ],
          ),
        ),
      );
    });
  }
}
