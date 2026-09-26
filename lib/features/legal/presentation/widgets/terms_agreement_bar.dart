import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class TermsAgreementBar extends StatefulWidget {
  final VoidCallback _onAgreePressed;

  const new({
    super.key,
    required this._onAgreePressed
  });

  @override
  State<TermsAgreementBar> createState() => _TermsAgreementBarState();
}

final class _TermsAgreementBarState extends State<TermsAgreementBar> {
  final ValueNotifier<bool> _isAgreedController = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isAgreedController.dispose();
    super.dispose();
  }

  @override
  Material build(BuildContext context)
  => Material(
    color: Theme.of(context).colorScheme.surface,
    shape: Border(top: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2.0)),
    child: Padding(
      padding: const .all(pageContentPadding),
      child: ValueListenableBuilder<bool>(
        valueListenable: _isAgreedController,
        builder: (BuildContext context, bool isAgreed, Widget? child)
        => Column(
          mainAxisSize: .min,
          spacing: defaultItemsSeparator,
          children: <Widget>[
            CheckboxListTile(
              value: isAgreed,
              onChanged: (bool? value) => _isAgreedController.value = value ?? false,
              controlAffinity: .trailing,
              contentPadding: const .symmetric(horizontal: 16.0),
              tileColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: const .all(.circular(12.0)),
                side: BorderSide(color: Theme.of(context).colorScheme.outline)
              ),
              title: child!,
            ),
            ElevatedButton(
              onPressed: isAgreed? widget._onAgreePressed: null,
              child: Text(context.l10n.agree)
            )
          ]
        ),
        child: Text.rich(
          TextSpan(
            style: TextStyles.font14Weight400,
            children: <TextSpan>[
              TextSpan(text: "${context.l10n.agreeToTermsPrefix} "),
              TextSpan(
                text: context.l10n.termsAndConditions,
                style: TextStyles.font14Weight700.copyWith(
                  color: Theme.of(context).colorScheme.primary
                )
              )
            ],
          ),
        ),
      ),
    ),
  );
}
