import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ndialog/ndialog.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
import 'package:pikunikku/pages/register/widgets/navigation_button.dart';
import 'package:pikunikku/pages/register/widgets/register_field.dart';
// import 'package:pikunikku/sources/api/API.dart';
// import 'package:provider/src/provider.dart';
// import 'package:provider/src/provider.dart';

class AddressForm extends StatelessWidget {
  final FocusNode? addressFocus;
  const AddressForm({Key? key, this.addressFocus}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Column(
        children: [
          // DropdownRegisterField(
          //   label: "Provinsi",
          //   item: state.listProvince != null?state.listProvince!
          //       .map((e) => DropdownMenuItem(
          //           value: e.provinsi, child: Text("${e.provinsi}")))
          //       .toList():[],
          //   onChanged: (value)=>context.read<RegisterCubit>().onProvinceChanged(value.toString()),
          //   value: state.province?.provinsi,
          //   placeholder: "Pilih Provinsi",
          // ),
          // state.province!=null?DropdownRegisterField(
          //   label: "Kota/Kabupaten",
          //   item: state.listCity != null?state.listCity!
          //       .map((e) => DropdownMenuItem(
          //           value: e.kota, child: Text("${e.kota}")))
          //       .toList():[],
          //   onChanged: (value)=>context.read<RegisterCubit>().onCityChanged(value.toString()),
          //   value: state.city?.kota,
          //   placeholder: "Pilih Kota/Kabupaten",
          // ):SizedBox(),
          // state.city!=null?DropdownRegisterField(
          //   label: "Kecamatan",
          //   item: state.listUniqueKecamatan != null?state.listUniqueKecamatan!
          //       .map((e) => DropdownMenuItem(
          //           value: e, child: Text("$e")))
          //       .toList():[],
          //   onChanged: (value)=>context.read<RegisterCubit>().onKecamatanChanged(value.toString()),
          //   value: state.kecamatan,
          //   placeholder: "Pilih Kecamatan",
          // ):SizedBox(),
          // state.kecamatan!=null?DropdownRegisterField(
          //   label: "Kelurahan",
          //   item: state.listKelurahan != null? state.listKelurahan!
          //       .map((e) => DropdownMenuItem(
          //           value: e, child: Text("$e")))
          //       .toList():[],
          //   onChanged: (value)=>context.read<RegisterCubit>().onKelurahanChanged(value.toString()),
          //   value: state.kelurahan,
          //   placeholder: "Pilih Kelurahan",
          // ):SizedBox(),
          // state.kelurahan!=null? RegisterField(
          //   label: "Kode Pos",
          //   value: state.kodePos,
          //   inputType: TextInputType.none,
          //   enabled: true,
          //   // onChanged: (value) =>
          //   //     context.read<RegisterCubit>().onKodePosChanged(value),
          // ):SizedBox(),
          // TextButton(
          //   child: Text("Tes"),
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           return AlertDialog(
          //             title: Text('Pilih Provinsi'),
          //             content: Container(
          //               height: 300.0, // Change as per your requirement
          //               width: 300.0, // Change as per your requirement
          //               child: ListView.builder(
          //                 shrinkWrap: true,
          //                 itemCount: state.listProvince!.length,
          //                 itemBuilder: (BuildContext context, int index) {
          //                   return ListTile(
          //                     title: Text(state.listProvince![index].provinsi.toString()),
          //                   );
          //                 },
          //               ),
          //             ),
          //           );
          //         });
          //   },
          // ),
          CustomRegisterField(
            defaultValue: "Pilih Provinsi",
            label: "Provinsi",
            value: state.province!=null?state.province!.provinsi:"Pilih Provinsi",
            buildContent: context.read<RegisterCubit>().listProvinsiContent(context),
            showButton: true,
          ),
          CustomRegisterField(
            defaultValue: "Pilih Kota/Kabupaten",
            label: "Kota/Kabupaten",
            value: state.city!=null?state.city!.kota:"Pilih Kota/Kabupaten",
            buildContent: context.read<RegisterCubit>().listKotaContent(context),
            showButton: state.listCity!=null?state.listCity!.length!=0?true:false:false,
          ),
          CustomRegisterField(
            defaultValue: "Pilih Kecamatan",
            label: "Kecamatan",
            value: state.kecamatan??"Pilih Kecamatan",
            buildContent: context.read<RegisterCubit>().listKecamatanContent(context),
            showButton: state.listKecamatan!=null?state.listKecamatan!.length!=0?true:false:false,
          ),
          CustomRegisterField(
            defaultValue: "Pilih Kelurahan",
            label: "Kelurahan",
            value: state.kelurahan,
            buildContent: context.read<RegisterCubit>().listKelurahanContent(context),
            showButton: state.kecamatan!=null&&state.kecamatan!=""?true:false,
          ),
          RegisterField(
            label: "Kode Pos",
            showField: false,
            text: state.kodePos!=null?state.kodePos!=""?state.kodePos:"(Akan terisi secara otomatis)":"(Akan terisi secara otomatis)",
          ),
          RegisterField(
            label: "Alamat Lengkap",
            maxlines: 3,
            value: state.address,
            onChanged: (value) =>
                context.read<RegisterCubit>().onAddressChanged(value),
            inputType: TextInputType.multiline,
            focusNode: addressFocus,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavigationButton(
                enabled: true,
                type: NavigationButton.before,
                onPressed: () {
                  context.read<RegisterCubit>().beforeProgress();
                },
              ),
              state.addressTrue == true
                  ? state.loading == true
                      ? Center(child: CircularProgressIndicator())
                      : NavigationButton(
                          enabled: true,
                          type: NavigationButton.finish,
                          onPressed: () {
                            addressFocus!.unfocus();
                            context
                                .read<RegisterCubit>()
                                .registerMultipart(context);
                          },
                        )
                  : SizedBox()
            ],
          ),
        ],
      );
    });
  }
}
