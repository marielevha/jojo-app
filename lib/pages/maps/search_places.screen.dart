import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:jojo/utils/constants.dart';

import 'package:jojo/utils/functions.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchScreenState extends State<SearchScreen> {
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);

  Set<Marker> markersList = {};
  final Set<Marker> _markers = {
    const Marker(markerId: MarkerId("source"), position: LatLng(33.589886, -7.603869)),
    const Marker(markerId: MarkerId("destination"), position: LatLng(34.020882, -6.841650)),
  };

  late GoogleMapController googleMapController;
  late GoogleMapController _controller;

  final LatLng _initialCameraPosition = const LatLng(33.589886, -7.603869);
  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: const Text("Google Search Places"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markersList,
            mapType: MapType.normal,
            /*onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },*/
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            onTap: (latlng) {
              if(markersList.isNotEmpty)
              {
                markersList.clear();
              }
              _onAddMarkerButtonPressed(latlng);
            },
          ),
          /*GoogleMap(
            initialCameraPosition: CameraPosition(target: _initialCameraPosition),
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            markers: _markers,
            onTap: (latlng) {
              if(_markers.isNotEmpty)
              {
                _markers.clear();
              }

              _onAddMarkerButtonPressed(latlng);
            },
          ),*/
          ElevatedButton(onPressed: _handlePressButton, child: const Text("Search Places"))
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country,"pk"),Component(Component.country,"usa")]);


    displayPrediction(p!,homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));

  }

  Future<void> _onAddMarkerButtonPressed(LatLng latlng) async {
    printError("ADDRESS LATITUDE: ${latlng.latitude}");
    printError("ADDRESS LONGITUDE: ${latlng.longitude}");

    /*markersList.clear();
    markersList.add(Marker(markerId: const MarkerId("0"),position: LatLng(latlng.latitude, latlng.longitude),infoWindow: const InfoWindow(title: 'Address')));

    setState(() {});

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(latlng.latitude, latlng.longitude), 14.0));
*/
    // From coordinates
    //var response = await getAddressFromLatLng(context, latlng.latitude, latlng.longitude);
    /*final coordinates = Coordinates(latlng.latitude, latlng.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    printError("ADDRESS: ${first.featureName} : ${first.addressLine}");*/
    /*loadAddress(latlang);
    _latLng = latlang;
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: latlang,
        infoWindow: InfoWindow(
          title: address,
          //  snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });*/
  }

  void _onMapCreated(GoogleMapController mapController) {
    _controller = mapController;
    //_location.onLocationChanged.listen((l) {
      //if (l.latitude != null && l.longitude != null) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _initialCameraPosition),
          ),
        );
      //}
    //});
  }

  getAddressFromLatLng(context, double lat, double lng) async {
    /*List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);

    for (var element in placeMarks) {
      printWarning(element);
    }

    return placeMarks;*/
  }
}