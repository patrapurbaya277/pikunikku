import 'package:flutter/material.dart';
// import 'package:pikunikku/sources/api/url.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ItineraryPage extends StatelessWidget {
  final String? pdfUrl;
  const ItineraryPage({Key? key, this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Itinerary"),
        backgroundColor: Color(0xff00adef)
      ),
      body: Container(
        child: SfPdfViewer.network(
          pdfUrl.toString()
        ),
      ),
    );
  }
}
