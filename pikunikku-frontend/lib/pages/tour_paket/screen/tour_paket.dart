import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/paket/paket_cubit.dart';
import 'package:pikunikku/pages/tour_paket/widgets/paket_item.dart';

class PaketPage extends StatefulWidget {
  const PaketPage({Key? key}) : super(key: key);

  @override
  _PaketPageState createState() => _PaketPageState();
}

class _PaketPageState extends State<PaketPage> {

  @override
  Widget build(BuildContext context) {
    context.read<PaketCubit>().getListPaket();
    return BlocBuilder<PaketCubit, PaketState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
              "Pilih paket yang tersedia",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            )),
        body: state.listPaket == null
            ? SizedBox()
            : state.hasFilteredData == false
                ? Center(child: Text("Tidak ada paket yang tersedia"))
                : ListView(
                    children: state.listPaket!
                        .where(
                            (element) => element.configPaketId == state.filter)
                        .map((e) => PaketItem(
                              paket: e,
                            ))
                        .toList(),
                  ),
      );
    });
  }
}
