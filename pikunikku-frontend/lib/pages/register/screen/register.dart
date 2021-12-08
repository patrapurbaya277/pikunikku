import 'package:flutter/material.dart';
import 'package:pikunikku/pages/register/widgets/account_form.dart';
import 'package:pikunikku/pages/register/widgets/address_form.dart';
import 'package:pikunikku/pages/register/widgets/card_container.dart';
import 'package:pikunikku/pages/register/widgets/identity_form.dart';
// import 'package:pikunikku/features/register/widgets/register_field.dart';
// import 'package:pikunikku/features/register/widgets/top_clip_path.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));
  String selectedText = "akun";
  int selectedForm = 0;

  Widget createSubText(String text) {
    TextStyle subStyle = TextStyle(
        color: Color(0xffAFAFAF), fontSize: 18, fontWeight: FontWeight.w300);

    TextStyle selectedStyle = TextStyle(
        color: Color(0xff00ADEF), fontSize: 18, fontWeight: FontWeight.w500);
    return Center(
        child: Text(
      "$text",
      style: text.toLowerCase() == selectedText ? selectedStyle : subStyle,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff00ADEF),
                Color(0xff7FCCEB),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 135,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(200)),
                color: Colors.white,
              ),
              child: SizedBox(
                height: 100,
                width: 300,
                child: Image.asset(
                  "assets/images/logo_black.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              // leading: Icon(Icons.arrow_back, color: Colors.white),
            ),
            body: Center(
              child: CardContainer(
                children: [
                  Text(
                    "Daftar",
                    style: TextStyle(
                        color: Color(0xff00ADEF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Expanded(
                      //   child: TextButton(
                      //     child: createSubText("Akun"),
                      //     onPressed: () {
                      //       if(selectedText!="akun"){
                      //         setState(() {
                      //         selectedText="akun";
                      //       });
                      //       }
                      //     },
                      //   ),
                      // ),
                      Expanded(
                        child: InkWell(
                            child: createSubText("Akun"),
                            onTap: () {
                              if (selectedText != "akun") {
                                setState(() {
                                  selectedText = "akun";
                                  selectedForm = 0;
                                });
                              }
                            }),
                      ),
                      Expanded(
                        child: InkWell(
                          child: createSubText("Data Diri"),
                          onTap: () {
                            if (selectedText != "data diri") {
                              setState(() {
                                selectedText = "data diri";
                                selectedForm = 1;
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: createSubText("Alamat"),
                          onTap: () {
                            if (selectedText != "alamat") {
                              setState(() {
                                selectedText = "alamat";
                                selectedForm = 2;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  [
                    SlideTransition(
                      position: _offsetAnimation,
                      child: AccountField(),
                    ),
                    IdentityForm(),
                    AddressForm(),
                  ][selectedForm]
                ],
              ),
            )),
      ],
    );
  }
}
