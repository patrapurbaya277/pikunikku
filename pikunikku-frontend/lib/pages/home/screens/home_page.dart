
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';

class HomePage extends StatefulWidget {
  static String home = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // tourBloc.getAllTour();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, user) {
          return Container(
            // child: Text(user.user!.nama),
            child: TextButton(
            onPressed: () {
              context.read<UserCubit>().logout();
              Navigator.pop(context);
            },
            child: Center(child: Text("Logout")),
          ),
          );
        }
      ),
    );
  }
}

// class TourDetail extends StatelessWidget {
//   final Tour? tour;
//   const TourDetail({Key? key, this.tour}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // print(APIUrl.baseNotBeta+(json.decode(tour!.pict??"")[0]).toString());
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Column(
//         children: [
//           Image.network(APIUrl.baseNotBeta +
//               (json.decode(tour!.pict ?? "")[0]).toString()),
//           Text(tour!.name ?? ""),
//         ],
//       ),
//     );
//   }
// }
