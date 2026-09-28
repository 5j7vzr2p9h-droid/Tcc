import 'package:flutter/material.dart';

import '../extensions/context_l10n.dart';

abstract final class Validators {
  static FormFieldValidator<String> getNameValidator(BuildContext context)
  => (String? value) => value!.trim().isEmpty? context.l10n.nameIsRequired: null;

  static FormFieldValidator<String> getPhoneNumberValidator(BuildContext context)
  => (String? value){
    if(value!.isEmpty)
      return context.l10n.phoneIsRequired;
    else if(!RegExp(r"^(?:\+20)?0?1[0125]\d{8}$").hasMatch(value))
      return context.l10n.invalidPhoneNumber;
    return null;
  };

  static FormFieldValidator<int> getRegionDropdownValidator(BuildContext context)
  => (int? value){
    if(value == null)
      return context.l10n.regionIsRequired;
    return null;
  };

  static FormFieldValidator<String> getDetailedAddressValidator(BuildContext context)
  => (String? value){
    if(value!.isEmpty)
      return context.l10n.detailedAddressRequired;
    return null;
  };

  static FormFieldValidator<String> getInstaPayUsernameValidator(BuildContext context)
  => (String? value){
    if(value!.isEmpty) return context.l10n.requiredField;
    else if(!RegExp(r'^[a-zA-Z0-9._]{3,30}$').hasMatch(value))
      return context.l10n.invalidUserName;
    return null;
  };

  static FormFieldValidator<String> getAuthAddressValidator(BuildContext context)
  => (String? value) => value!.isEmpty
  ? context.l10n.addressIsRequired
  : null;
}