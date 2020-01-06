import 'package:flutter/material.dart';
import 'package:uas/src/models/anggreks.dart';
import 'package:uas/src/ui/detail.dart';
import 'package:uas/src/utils/navigate.dart';

class ItemLayout extends StatelessWidget {
  const ItemLayout(this._anggreks);
  @required
  final Anggreks _anggreks;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Hero(
                    // tag: "image${_anggreks.id}",
                    tag: "image${_anggreks.id}",
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/no_image.png",
                      // placeholder: "",
                      image: _anggreks.image,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: Text(
                    _anggreks.name,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // onPressed: () => Navigate.gotoDetail(context),
                  onTap: () => goToDetailsPage(context, _anggreks),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  goToDetailsPage(BuildContext context, Anggreks anggreks) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => Detail(
              anggreks: anggreks,
            ),
      ),
    );
  }

  // void goToDetailsPage(BuildContext context, Anggreks anggreks) async {
  //   await Navigator.push(context,MaterialPageRoute(builder: (context) => Detail(anggreks)));
  // }

}