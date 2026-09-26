import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/numerical_values.dart';

final class DefaultMap extends StatefulWidget {
  final LatLng _userLocation;
  final ValueNotifier<LatLng> _mapPositionController;

  const DefaultMap({
    required this._userLocation,
    required this._mapPositionController,
    super.key
  });

  @override
  State<DefaultMap> createState() => _DefaultMapState();
}

class _DefaultMapState extends State<DefaultMap> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  @override
  Stack build(BuildContext context)
  => Stack(
    children: <Widget>[
      ValueListenableBuilder<LatLng>(
        valueListenable: widget._mapPositionController,
        builder: (BuildContext context, LatLng latLng, Widget? _) {
          _animateCameraToPosition();
          return GoogleMap(
            
            markers: <Marker>{
                Marker(markerId: const MarkerId(""), position: latLng),
            },
            compassEnabled: false,
            zoomControlsEnabled: true,
            markerType: .advancedMarker,
            initialCameraPosition: CameraPosition(
              target: latLng,
              tilt: 0.0,
              zoom: 19.151926040649414,
            ),
            onTap: (LatLng latLng) => widget._mapPositionController.value = latLng,
              // showBottomSheet(
              //             context: context,
              //             shape: const RoundedRectangleBorder(
              //               borderRadius: .vertical(top: .circular(16.0))
              //             ),
              //             builder: (BuildContext context) => Padding(
              //               padding: const .all(pageContentPadding),
              //               child: Form(
              //                 key: _formKey,
              //                 child: Column(
              //                   mainAxisSize: .min,
              //                   crossAxisAlignment: .stretch,
              //                   spacing: 16.0,
              //                   children: <Widget>[
              //                     AddressDropdownField(
              //                       (String? value){
                              
              //                       }
              //                     ),
              //                     AddressTextField(
              //                       textController: _notesController,
              //                       linesNumber: 3,
              //                       label: context.l10n.detailedAddress,
              //                       hint: context.l10n.additionalNotesHint,
              //                       icon: Icons.edit_note,
              //                     ),
              //                     PrimaryAddressSwitch(controller: _isPrimaryController),
              //                     ElevatedButton(
              //                       onPressed: () {
              //                         if(_formKey.currentState!.validate()){
                            
              //                         }
              //                       },
              //                       child: Text(context.l10n.confirmAddress)
              //                     )
              //                   ],
              //                 ),
              //               )
              //             )
              //           );
            onMapCreated: (GoogleMapController controller) {
              if(!_mapController.isCompleted)
                _mapController.complete(controller);
            },
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
          );
        },
      ),
      Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: const .all(pageContentPadding),
          child: FloatingActionButton(
            onPressed: () => widget._mapPositionController.value = widget._userLocation,
            child: const Icon(Icons.gps_fixed),
          ),
        ),
      )
    ],
  );

  void _animateCameraToPosition() async
  => (await _mapController.future).animateCamera(
    CameraUpdate.newLatLng(widget._mapPositionController.value)
  );
}