import 'package:flutter/material.dart';
import 'package:pikunikku/pages/about/widgets/faq_item.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:pikunikku/sources/model/faq.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);
  static List<FAQClass> listFAQ = [
    FAQClass(
        answer:
            "Iya. Registrasi awal sangat berguna untuk kalian loh PikuFriend. Selain akan mendapatkan rekomendasi liburan seru di dunia Pikunikku, mendapatkan diskon spesial, kesempatan early bird petualangan ke destinasi-destinasi seru hingga mendapatkan PikuPoin",
        question:
            "Pikunikku bantu kamu yang lagi suntuk. Ajak keluargamu liburan tipis-tipis dengan petualangan seru. Cek disini!"),
    FAQClass(question: "Bagaimana cara memesan program tour di Pikunikku?", answer: "Melalui Website atau Aplikasi Mobile"),
    FAQClass(question: "Bisakah saya menyimpan pesanan saya untuk digunakan nanti?", answer: "Refer pilihan menabung atau bayar sekarang jalan nanti"),
    FAQClass(question: "Apakah bisa memesan program tour atas nama keluarga/group?", answer: "Tentu bisa! Apabila peserta ingin merequest untuk private silahkan klik button Contact CS"),
    FAQClass(question: "Dimanakah menemukan titik penjemputan?", answer: "Titik penjemputan terdapat di setiap penjelasan destinasi"),
    FAQClass(question: "Mengapa tidak bisa menyelesaikan pemesanan program tour?",answer: "Hal ini bisa terjadi jika kuota pemesanan sudah penuh, pembayaran belum terverifikasi, atau adanya perubahan waktu program. Pastikan koneksi internet kamu lancar saat melakukan pemesanan ya PikuFriend"),
    FAQClass(question: "Bagaimana cara mengetahui bahwa pemesanan telah terkonfirmasi?",answer: "Pemesanan terkonfirmasi akan diemail dan atau whatsapp."),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height + 100,
      child: Column(
        // children: state.listTestimoni!=null?state.listTestimoni!.map((e) => TestimoniItem(testimoni: e,)).toList():[SizedBox()],
        children: [
          ...listFAQ
              .map((e) => FAQItem(faq: e,))
              .toList(),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              const url = URL.moreFAQ;

              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text(
              "Lihat Selengkapnya",
              style: TextStyle(
                color: Color(0xff00adef).withOpacity(0.8),
                fontSize: 17,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
