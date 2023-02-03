import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:jojo/pages/maps/country.component.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';


class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}


class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};
  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: const Text("User current location"),
        centerTitle: true,
      ),
      body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markers,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              onTap: (latlng) {
                printWarning("Latitude: ${latlng.latitude}");
                printWarning("Longitude: ${latlng.longitude}");

                if(markers.isNotEmpty)
                {
                  markers.clear();
                }
                setState(() {
                  markers.add(Marker(
                    markerId: MarkerId("JOjo"),
                    position: latlng,
                    infoWindow: const InfoWindow(
                      title: "JOjo Bull",
                      //  snippet: '5 Star Rating',
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                  ));
                });
                Navigator.of(context).pop(latlng);
              },
            ),
            ElevatedButton(onPressed: _handlePressButton, child: const Text("Search Places"))
          ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
          markers.clear();
          //markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));
          setState(() {});
        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
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
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))
        ),
        components: kGoogleApiCountryComponent
    );

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

    printError(detail.result.name);
    printError(detail.result.formattedAddress.toString());
    markers.clear();
    markers.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));

  }

  Future<void> _onAddMarkerButtonPressed(LatLng latlng) async {
    printError("Latitude : ${latlng.latitude}");
    printError("Longitude : ${latlng.longitude}");
    // From coordinates
    //var response = await getAddressFromLatLng(context, latlng.latitude, latlng.longitude);
    /*final coordinates = Coordinates(latlng.latitude, latlng.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    printError("ADDRESS: ${first.featureName} : ${first.addressLine}");*/
    //printError("ADDRESS: $response");
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
}