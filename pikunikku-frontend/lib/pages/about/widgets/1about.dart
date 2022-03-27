import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Image.asset(
              "assets/images/logo_white.png",
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
        ),
        Text(
          "TRAVEL PLANNER PALING SERU !",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        Divider(
          color: Colors.white,
          thickness: 3,
          endIndent: MediaQuery.of(context).size.width * 0.75,
          height: 30,
        ),
        Text(
          '''Berlibur ke luar negeri adalah impian bagi banyak orang, apalagi kalau bersama keluarga dan teman-teman terdekat. Tentunya pengalaman terbaik dan kesempatan untuk mengunjungi tempat yang sudah masuk bucket list adalah keinginan setiap traveler
    
    Sayangnya, seringkali ketika berlibur bersama tour operator justru mendapatkan pengalaman yang kurang puas. Padahal ingin berlama-lama di tempat yang sudah masuk bucket list untuk explore sampai puas, tapi terkadang tour operator memberikan waktu yang sangat terbatas. Sedangkan kalau berlibur sendiri, ada banyak hal yang harus disiapkan dan berlibur jadi sumber stress lain karena harus memastikan semua kebutuhan terpenuhi.
    
    PIKUNIKKU ada untuk menjawab keinginan kamu yang ingin berlibur puas tanpa ribet!''',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
