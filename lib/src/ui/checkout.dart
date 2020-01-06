import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:uas/src/models/anggreks.dart';
import 'package:uas/src/utils/pdf_viewer.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
  final Anggreks anggreks;
  final int total;
  Checkout({@required this.anggreks, this.total});
}

class _CheckoutState extends State<Checkout> {
  // TextEditingController _c = new TextEditingController();
  // TextEditingController _c;
  
  String getbayar;
  int _bayar = 0;
  int _kembalian = 0;

  @override
  void initState() { 
    // _c = new TextEditingController();
    super.initState();
    // _c.addListener(
    //   getbayar = 
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.pink[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        title: new Text(
          "CheckOut"
        ),
      ),
      body: new Stack(
        children: <Widget>[
          // new Image(
          //   image: new AssetImage('images/background.jpg'),
          //   fit: BoxFit.cover,
          //   color: Colors.black38,
          //   colorBlendMode: BlendMode.darken,
          // ),
          new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.pink[200],Colors.pinkAccent]
              )
            ),
            height: 210.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  (widget.total).toString(),
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                new Text(
                  'Total Pembayaran',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Pembayaran",
                    style:TextStyle(
                      fontSize: 25.0, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(padding: new EdgeInsets.only(bottom: 50.0),),
                  Container(
                    padding: new EdgeInsets.only(left: 40.0,right: 40.0, top: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: new InputDecoration(
                            labelText: "Bayar",
                          ),
                          onChanged: (v) => setState(() {
                            getbayar = v;
                            _bayar = int.parse('$getbayar');
                            _kembalian = _bayar - widget.total;
                          }),
                          keyboardType: TextInputType.number,
                          // controller: _c,
                        ),
                        // TextField(
                        //   decoration: new InputDecoration(
                        //     hintText: "$getbayar"
                        //   ),
                        //   keyboardType: TextInputType.number,
                        //   // onChanged: (r) => setState((){
                        //   //   _bayar = double.parse(_c.text);
                        //   //   _hasil = widget.total - _bayar;
                        //   // }),
                        // ),
                        // Text("prin input : $getbayar"),
                        // Text("prin bayar : $_bayar"),
                        Padding(padding: new EdgeInsets.only(bottom: 25.0),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Kembalian",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Text("Rp $_kembalian"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          new Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),),
                new MaterialButton(
                  height: 40.0,
                  minWidth: 150.0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)
                  ),
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                  child: new Text(
                    'Submit',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  splashColor: Colors.purpleAccent,
                  onPressed: () => _generate(context),
                )
              ],
            ),
          ),
          
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Hero(
          //     tag: "",
          //     child: Container(
          //       height: 200.0,
          //       width: 200.0,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(50.0),
          //         // image: DecorationImage(
          //         //   fit: BoxFit.cover, 
          //         //   image: AssetImage('images/no_image.png')
          //         // )
          //       ),
          //     )
          //   ),
          // ),
        ],
      ),
    );
  }

  // void _calculate(String v){
  //   setState(() {
  //     getbayar = v;
  //     _bayar = int.parse(getbayar);
  //     _kembalian = _bayar - widget.total;
  //   });
  // }

  _generate(context) async {
    // final Uint8List fontData = File('open-sans.ttf').readAsBytesSync();
    // final ttf = pdfLib.Font.ttf(fontData.buffer.asByteData());
    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

    pdf.addPage(
      pdfLib.MultiPage(
        build: (context) =>[
          pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
            <String>
            ['Total', 'Pembayaran', 'Kembalian'],
            [widget.total.toString(),_bayar.toString(),_kembalian.toString()]
          ]),
        ],
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/checkout.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Pdf_Viewer(path: path)
      )
    );
    
  }

}
