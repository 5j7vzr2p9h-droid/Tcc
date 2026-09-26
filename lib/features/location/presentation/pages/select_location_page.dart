import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/app_dialog.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/default_circular_indicator.dart';
import '../../../delivery/presentation/widgets/address_dropdown_field.dart';
import '../../../delivery/presentation/widgets/address_text_field.dart';
import '../../../delivery/presentation/widgets/primary_address_switch.dart';
import '../widgets/default_map.dart';
import '../../../../core/widgets/search_text_field.dart';
import '../../../delivery/domain/entities/suggested_place_entity.dart';
import '../../viewmodels/select_location_viewmodel/select_location_cubit.dart';
import '../../viewmodels/select_location_viewmodel/select_location_state.dart';

final class const SelectLocationPage(final bool _isInitial, {super.key}) extends StatefulWidget {

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

final class _SelectLocationPageState extends State<SelectLocationPage> {

  final ValueNotifier<LatLng> _mapPositionController = ValueNotifier(const LatLng(0.0, 0.0));
  final TextEditingController _notesController = TextEditingController(), _searchController = TextEditingController();
  final ValueNotifier<bool> _isPrimaryController = ValueNotifier<bool>(true),
    _resultsContainerShowController = ValueNotifier<bool>(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Debouncer _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void dispose(){
    _mapPositionController.dispose();
    _resultsContainerShowController.dispose();
    _debouncer.cancel();
    super.dispose();
  }


  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.selectYourLocation, style: TextStyles.font18Weight700),
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
    ),
    body: BlocConsumer<SelectLocationCubit, SelectLocationState>(
      listener: (BuildContext context, SelectLocationState state){
        if(state is SelectLocationGetDeviceLocationSuccessState)
          _mapPositionController.value = LatLng(state.myLocationCoordinates[0], state.myLocationCoordinates[1]);
        else if(state is SelectPlaceSuccessState){
          _mapPositionController.value = LatLng(state.selectedPlaceCoordinates[0], state.selectedPlaceCoordinates[1]);

        }
        else if(state is SearchPlaceFailureState)
          SnackBarMessage.showErrorMessage(
            context,
            (state.failure).mapFailureToMessage(context)
          );
        else if(state is SelectPlaceFailureState)
          SnackBarMessage.showErrorMessage(
            context,
            (state.failure).mapFailureToMessage(context)
          );
        else if(state is ConfirmingLocationState)
          AppDialog.showLoadingDialog(context);
        else if(state is ConfirmLocationFailureState){
          Navigator.pop(context);
          _searchController.clear();
          SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
        }
        else if(state is ConfirmLocationSuccessState)
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (Route<dynamic> predicate) => false
          );
      },
      builder: (BuildContext context, SelectLocationState state) => switch(state){
        SelectLocationInitialState() => const SizedBox.shrink(),
        SelectLocationLoadingState() => const Center(child: DefaultCircularIndicator()),
        SelectLocationInitializationFailureState() => const SizedBox.shrink(),
        SelectLocationGetDeviceLocationSuccessState(:final List<double> myLocationCoordinates) ||
        SearchPlaceSuccessState(:final List<double> myLocationCoordinates) ||
        SearchPlaceFailureState(:final List<double> myLocationCoordinates) ||
        SearchPlaceLoadingState(:final List<double> myLocationCoordinates) ||
        SelectPlaceSuccessState(:final List<double> myLocationCoordinates) ||
        SelectPlaceFailureState(:final List<double> myLocationCoordinates) ||
        SelectPlaceLoadingState(:final List<double> myLocationCoordinates) ||
        ConfirmingLocationState(:final List<double> myLocationCoordinates) ||
        ConfirmLocationFailureState(:final List<double> myLocationCoordinates) ||
        ConfirmLocationSuccessState(:final List<double> myLocationCoordinates)
        => Stack(
          children: <Widget>[
            DefaultMap(
              userLocation: LatLng(myLocationCoordinates[0], myLocationCoordinates[1]),
              mapPositionController: _mapPositionController,
            ),
            Padding(
              padding: const .all(pageContentPadding),
              child: SearchTextField(
                controller: _searchController,
                hintText: context.l10n.searchPlaceAddress,
                suffixIcon: ValueListenableBuilder(
                  valueListenable: _resultsContainerShowController,
                  builder: (BuildContext context, bool isShown, Widget? _)
                  => IconButton(
                      onPressed: (){
                        if(isShown){
                          _resultsContainerShowController.value = false;
                          _searchController.clear();
                        }
                      },
                      icon: Icon(
                        isShown
                          ? Icons.close
                          : Icons.gps_fixed,
                        color: isShown
                          ? Theme.of(context).colorScheme.primary
                          : null
                      )
                    )
                ),
                onChanged: (String query) {
                  if(query.isNotEmpty){
                    _resultsContainerShowController.value = true;
                    _debouncer.run(
                      () => context.read<SelectLocationCubit>().searchPlace(query)
                    );
                  }
                  else _resultsContainerShowController.value = false;
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _resultsContainerShowController,
              builder: (BuildContext context, bool isShown, Widget? child)
              => isShown? child!: const SizedBox.shrink(),
              child: Positioned(
                top: 60.0,
                left: 0.0,
                right: 0.0,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween<double>(
                    begin: 0.0,
                    end: 1.0
                  ),
                  builder: (BuildContext context, double value, Widget? child) => Container(
                    height: 350.0 * value,
                    margin: const .all(pageContentPadding),
                    child: Material(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      clipBehavior: .antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: const .all(.circular(12.0)),
                        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                      ),
                      child: state is SearchPlaceSuccessState? ListView.separated(
                        itemCount: state.suggestedPlaces.length,
                        separatorBuilder: (BuildContext _, int _) => const SizedBox(height: 4.0),
                        itemBuilder: (BuildContext context, int i) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: const Icon(Icons.location_on)
                          ),
                          title: Text(state.suggestedPlaces[i].placeTitle, style: TextStyles.font14Weight400),
                          onTap: () => _selectPlace(context, state.suggestedPlaces[i]),
                        ),
                      ): const Center(child: DefaultCircularIndicator()),
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      },
    ),
    bottomNavigationBar: BottomAppBar(
      child: Builder(
        builder: (BuildContext context) => ElevatedButton(
          onPressed: () => widget._isInitial
            ? context.read<SelectLocationCubit>().confirmLocation(
              lat: _mapPositionController.value.latitude,
              lng: _mapPositionController.value.longitude
            )
            : showBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: .vertical(top: .circular(16.0))
              ),
              builder: (BuildContext context) => Padding(
                padding: const .all(pageContentPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .stretch,
                    spacing: 16.0,
                    children: <Widget>[
                      AddressDropdownField(
                        (String? value){

                        }
                      ),
                      AddressTextField(
                        textController: _notesController,
                        linesNumber: 3,
                        label: context.l10n.detailedAddress,
                        hint: context.l10n.additionalNotesHint,
                        icon: Icons.edit_note,
                      ),
                      PrimaryAddressSwitch(controller: _isPrimaryController),
                      ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){

                          }
                        },
                        child: Text(context.l10n.confirmAddress)
                      )
                    ],
                  ),
                )
              )
            ),
          child: Text(context.l10n.confirmLocation)
        ),
      ),
    ),
  );


  void _selectPlace(BuildContext context, SuggestedPlaceEntity suggestedPlace){
    _debouncer.cancel();
    FocusScope.of(context).unfocus();
    _searchController.text = suggestedPlace.placeTitle;
    _resultsContainerShowController.value = false;
    context.read<SelectLocationCubit>().selectPlace(suggestedPlace.placeId);
  }
}