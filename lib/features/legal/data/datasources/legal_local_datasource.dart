import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/legal_list_model.dart';

abstract interface class LegalLocalDatasource {
  void cachePrivacyPolicy(LegalListModel privacyPolicy);
  LegalListModel getCachedPrivacyPolicy();

  void cacheTermsAndConditions(LegalListModel termsAndConditions);
  LegalListModel getCachedTermsAndConditions();
}

final class LegalLocalDatasourceImpl implements LegalLocalDatasource{
  static const String _privacyPolicyKey = "privacy", _termsAndConditionsKey = "terms";

  final Box<LegalListModel> _box;

  const new(this._box);

  @override
  void cachePrivacyPolicy(LegalListModel privacyPolicy) => _box.put(_privacyPolicyKey, privacyPolicy);

  @override
  void cacheTermsAndConditions(LegalListModel termsAndConditions) => _box.put(_termsAndConditionsKey, termsAndConditions);

  @override
  LegalListModel getCachedPrivacyPolicy() => _getCachedLegalList(_privacyPolicyKey);

  @override
  LegalListModel getCachedTermsAndConditions() => _getCachedLegalList(_termsAndConditionsKey);

  LegalListModel _getCachedLegalList(String key){
    final LegalListModel? legalList = _box.get(key);
    if(legalList != null && legalList.legalSections.isNotEmpty)
      return legalList;
    throw const EmptyCacheException();
  }
}
