import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:pikunikku/cubit/login/login_cubit.dart';
// import 'package:pikunikku/cubit/main/main_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
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
    return BlocBuilder<UserCubit,UserState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              title: Text("Profil", style: TextStyle(color: Colors.black),),
              actions: [
                Container(
                  child: TextButton(
                    onPressed: () {
                      context.read<UserCubit>().logout(context);
                    },
                    child: Center(
                        child: Text("Logout", style: TextStyle(color: Colors.red),)),
                  ),
                ),
              ]),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(image: NetworkImage(URL.imageProfile+state.user!.picture), fit: BoxFit.fitHeight),
                    shape: BoxShape.circle,
                  ),
                ),
                Divider(height:40),
                Text("Nama :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
                Text(state.user!.nama, style: TextStyle(fontSize: 16),),
                SizedBox(height: 20),
                Text("Tanggal Lahir :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
                Text(DateFormat("dd MMMM yyyy").format(state.user!.tglLahir), style: TextStyle(fontSize: 16),),
                SizedBox(height: 20),
                Text("Email :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
                Text(state.user!.email, style: TextStyle(fontSize: 16),),
                SizedBox(height: 20),
                Text("Nomor Handphone :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
                Text(state.user!.noHp, style: TextStyle(fontSize: 16),),
                SizedBox(height: 20),
                Text("Kota :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
                Text(state.user!.kota, style: TextStyle(fontSize: 16),),
                SizedBox(height: 20),
                Text("Provinsi :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
                Text(state.user!.provinsi,style: TextStyle(fontSize: 16),),
                SizedBox(height: 20),
                Text("Alamat :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
                Text(state.user!.alamat,style: TextStyle(fontSize: 16),),
                SizedBox(height: 20),
                Text("Kode Pos :", style: TextStyle(color: Color(0xff00adef), fontSize: 21),),
                Text(state.user!.kodePos,style: TextStyle(fontSize: 16),),
                
              ],
            ),
          ),
        );
      }
    );
  }
}
