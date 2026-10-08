import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/validators.dart';
import '../../../../di.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';
import '../../domain/entities/profile_entity.dart';
import '../controllers/profile_image_controller.dart';
import '../viewmodel/edit_profile_viewmodel/edit_profile_cubit.dart';
import '../viewmodel/edit_profile_viewmodel/edit_profile_state.dart';
import '../widgets/edit_profile_avatar.dart';

final class const EditProfilePage(final ProfileEntity _profile, {super.key}) extends StatefulWidget {

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

final class _EditProfilePageState extends State<EditProfilePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(),
    _phoneController = TextEditingController(),
    _addressController = TextEditingController();
  final ProfileImageController _profileImageController = ProfileImageController(ImagePicker());

  @override
  void dispose(){
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _profileImageController.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.editProfile),
    ),
    body: Form(
      key: _formKey,
      child: BlocProvider<EditProfileCubit>(
        create: (BuildContext context) => getIt<EditProfileCubit>()..init(widget._profile),
        child: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (BuildContext context, EditProfileState state){
            if(state is EditProfileSuccessState)
              Navigator.pop<ProfileEntity>(context, state.profile);
          },
          builder: (BuildContext context, EditProfileState state)
          => switch(state){
            EditProfileInitialState() => const SizedBox.shrink(),
            EditProfileSuccessState(:final ProfileEntity profile) ||
            EditProfileFailureState(:final ProfileEntity profile) ||
            EditProfileSetDataState(:final ProfileEntity profile) ||
            EditProfileUpdatingState(:final ProfileEntity profile)
            => ListView(
              padding: const .all(pageContentPadding),
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Center(
                  child: EditProfileAvatar(
                    imageUrl: profile.profileImageUrl,
                    imageController: _profileImageController,
                  ),
                ),
                const SizedBox(height: 40.0),
                AuthTextField(
                  textController: _nameController,
                  label: context.l10n.name,
                  hint: profile.name,
                  icon: Icons.person_outline_rounded,
                  keyboardType: .name,
                  validator: Validators.getPhoneNumberValidator(context),
                ),
                const SizedBox(height: 24.0),
                AuthTextField(
                  textController: _addressController,
                  label: context.l10n.address,
                  hint: profile.address,
                  icon: Icons.location_on_outlined,
                  keyboardType: .streetAddress,
                  validator: Validators.getAuthAddressValidator(context),
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    Expanded(
                      child: AuthTextField(
                        enabled: false,
                        textController: _phoneController,
                        label: profile.phone,
                        icon: Icons.phone_outlined,
                        keyboardType: .phone,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.editPhone),
                      color: Theme.of(context).colorScheme.primary,
                      icon: const Icon(Icons.edit_outlined)
                    ),
                  ],
                ),
                const SizedBox(height: 60.0),
                ElevatedButton(
                  onPressed: state is EditProfileUpdatingState
                    ? null
                    : (){
                      // Don't forget _formKey.currentState.validate ======================================<
                      if(_addressController.text.trim().isNotEmpty || _addressController.text.trim().isNotEmpty || _profileImageController.value != null)
                        context.read<EditProfileCubit>().updateProfile(
                          name: _nameController.text.trim().isEmpty
                            ? null
                            : _nameController.text,
                          address: _addressController.text.trim().isEmpty
                            ? null
                            : _addressController.text,
                          imagePath: _profileImageController.value
                        );
                  },
                  child: Text(context.l10n.saveChanges)
                ),
              ],
            ),
          }
        ),
      ),
    ),
  );
}