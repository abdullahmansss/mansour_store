import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/primary/primary_button.dart';
import 'package:mansour_store/core/util/constants/primary/primary_padding.dart';
import 'package:mansour_store/core/util/constants/routes.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';
import 'package:mansour_store/features/home/presentation/widgets/profile_widgets/profile_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorsManager.textColor,
          ),
          onPressed: () {
            context.pop;
          },
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.whiteColor,
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if(state is GetAddressSuccessState) {
            context.push(Routes.createAddressScreen);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(30.163656, 31.625738),
                  zoom: 18,
                ),
                markers: {
                  homeCubit.marker,
                },
                onCameraMove: (CameraPosition position) {
                  homeCubit.marker = Marker(
                    markerId: const MarkerId('current_location'),
                    position: position.target,
                    draggable: true,
                    infoWindow: InfoWindow(
                      title: 'Current Location',
                      snippet: 'Lat: ${position.target.latitude}, Lng: ${position.target.longitude}',
                    ),
                  );

                  // debugPrint('Camera moved to: ${position.target.latitude}, ${position.target.longitude}');
                },
                onCameraIdle: () {
                  // debugPrint('Camera movement stopped');
                },
                onCameraMoveStarted: () {
                  // debugPrint('Camera movement started');
                },
                onMapCreated: (GoogleMapController controller) {
                  homeCubit.mapsController = controller;
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: PrimaryButton(
                    onPressed: () {
                      homeCubit.getAddress();
                    },
                    text: 'Next',
                    isLoading: state is GetAddressLoadingState,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
