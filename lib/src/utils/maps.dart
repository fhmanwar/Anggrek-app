import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsLoc extends StatefulWidget {
  @override
  _MapsLocState createState() => _MapsLocState();
}

class _MapsLocState extends State<MapsLoc> {

  static final LatLng myloc = const LatLng(6.9829, 110.4091);
  GoogleMapController _mapController;


  final CameraPosition _kGooglePlex = CameraPosition(
    target: myloc,
    zoom: 11.0
  );

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('marker_1'),
        position: myloc,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
      )
    ].toSet();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locate Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: _createMarker(),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController cont) {
                _mapController = cont;
                setState(() {});
              },
            ),
            IgnorePointer(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Google Office\n",
                        style: Theme.of(context).textTheme.title.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        children: [
                          TextSpan(
                              text: "Shoreline Amphitheatre, Mountain View, CA",
                              style: Theme.of(context).textTheme.subtitle,
                              children: []),
                        ]),
                  )),
            )
          ],
        ),
      ),
    );
  }
}