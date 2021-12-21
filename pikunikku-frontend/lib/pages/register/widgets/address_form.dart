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
  const AddressForm({Key? key}) : super(key: key);
  static TextEditingController kotaController = TextEditingController();
  static TextEditingController provController = TextEditingController();
  static TextEditingController kodePosController = TextEditingController();
  static TextEditingController aLengkapController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (BuildContext context, state) {
        if (state.city != "" &&
            state.province != "" &&
            state.postalCode != "" &&
            state.address != "") {
          context.read<RegisterCubit>().addressConfirmation(true);
        } else {
          context.read<RegisterCubit>().addressConfirmation(false);
        }
      },
      child:
          BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
        return Column(
          children: [
            RegisterField(
              label: "Kota",
              value: state.city,
              onChanged: (value) =>
                  context.read<RegisterCubit>().onCityChanged(value),
            ),
            RegisterField(
              label: "Provinsi",
              value: state.province,
              onChanged: (value) =>
                  context.read<RegisterCubit>().onProvinceChanged(value),
            ),
            RegisterField(
              label: "Kode Pos",
              value: state.postalCode,
              inputType: TextInputType.number,
              onChanged: (value) =>
                  context.read<RegisterCubit>().onPostalCodeChanged(value),
            ),
            RegisterField(
              label: "Alamat Lengkap",
              maxlines: 3,
              value: state.address,
              onChanged: (value) =>
                  context.read<RegisterCubit>().onAddressChanged(value),
              inputType: TextInputType.multiline,
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
                    ? state.loading==true?Center(child: CircularProgressIndicator()): NavigationButton(
                        enabled: true,
                        type: NavigationButton.finish,
                        onPressed: (){
                          context.read<RegisterCubit>().registerMultipart(context);
                        },
                      )
                    : SizedBox()
              ],
            ),
          ],
        );
      }),
    );
  }
}
