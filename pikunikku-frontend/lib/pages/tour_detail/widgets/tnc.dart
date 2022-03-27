import 'package:flutter/material.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({Key? key}) : super(key: key);
  static List<String> listTitle = [
    "PEMBATALAN",
    "FORCE MAJURE",
    "PERUBAHAN KURS",
    "VISA",
    "IMIGRASI",
    "DOKUMENTASI",
    "",
    "",
  ];
  static List<String> listSubtitle = [
    "Uang muka dan pembayaran yang sudah masuk ke rekening Pikunikku.id tidak dapat dibatalkan/dipindahtangankan. Apabila peserta membatalkan maka tidak ada pengembalian.",
    "Dalam keadaan Force Majeure/terpaksa/tidak teratasi karena bencana alam, kerusuhan, suasana mencekam dan lain-lain, rencana perjalanan dapat dibatalkan/dirubah jadwal. Hal ini demi kepentingan dan keamanan seluruh peserta trip. Pembatalan/keterlambatan/perubahan peraturan bagasi/hambatan lain penerbangan yang disebabkan oleh pihak maskapai, transportasi lokal, hotel dan dokumen perjalanan, maka Pikunikku.id tidak dapat dituntut dan segala kerugian yang disebabkan hal tersebut akan menjadi tanggungan peserta trip. Pikunikku.id tidak bertanggung jawab dalam pengembalian biaya atau uang atas service yang sudah dibayarkan yang tidak digunakan, termasuk dan tidak terbatas pada biaya tambahan. Pikunikku.id akan semampunya membantu komunikasi kepada pihak terkait.",
    "Kurs maksimal 1 USD = Rp.14.500 , jika lebih akan ada penyesuaian biaya",
    "Proses persetujuan visa adalah sepenuhnya wewenang pihak kedutaan dan tidak dapat di intervensi oleh pihak manapun. Hal-hal lain yang berkaitan dengan proses tidak disetujuinya pengajuan visa akan menyesuaikan dengan prosedur yang berlaku dari pihak-pihak terkait. Apabila pengajuan visa ditolak maka tidak ada pengembalian atas biaya visa, asuransi, uang muka trip dan biaya lain yang sudah dibayarkan kepada pihak maskapai/hotel/transportasi lokal.",
    "Imigrasi negara yang dikunjungi memiliki hak untuk menerima dan menolak individu untuk berkunjung. Apabila ditolak, Pikunikku.id tidak bertanggung jawab akan hal ini",
    "Seluruh dokumentasi selama trip yang diambil oleh tim Pikunikku akan digunakan sebagai materi promosi.",
    "Demi kelancaran trip, acara perjalanan dapat berubah tanpa pemberitahuan lebih dahulu.",
    "Dengan melakukan pendaftaran, peserta telah dianggap menyetujui syarat & ketentuan.",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10, bottom: 5),
      child: ListView.builder(
          itemCount: listTitle.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (index + 1).toString() + ". ",
                  ),
                  SizedBox(width: 2),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: listTitle[index] != ""
                                ? listTitle[index] + ": "
                                : "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: listSubtitle[index])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
