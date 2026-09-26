import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/utils/text_styles.dart';

final class AuthTermsNote extends StatefulWidget {
  const AuthTermsNote({super.key});

  @override
  State<AuthTermsNote> createState() => _AuthTermsNoteState();
}

class _AuthTermsNoteState extends State<AuthTermsNote> {
  final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _privacyPolicyRecognizer = TapGestureRecognizer();

  @override
  void dispose(){
    _termsRecognizer.dispose();
    _privacyPolicyRecognizer.dispose();
    super.dispose();
  }

  @override
  Text build(BuildContext context)
  => Text.rich(
    TextSpan(
      style: TextStyles.font12Weight700.copyWith(color: Colors.grey),
      children: <InlineSpan>[
        const TextSpan(text: "بإنشاء حساب، أنت توافق على "),
        TextSpan(
          text: "الشروط والأحكام ",
          style: _linkStyle(context),
          recognizer: _termsRecognizer..onTap = () => Navigator.pushNamed(context, Routes.termsAndConditions)
        ),
        TextSpan(
          text: "وسياسة الخصوصية",
          style: _linkStyle(context),
          recognizer: _privacyPolicyRecognizer..onTap = () => Navigator.pushNamed(context, Routes.privacyPolicy)
        )
      ],
    ),
    textAlign: .center,
  );

  TextStyle _linkStyle(BuildContext context)
  => TextStyles.font12Weight700.copyWith(
    color: Theme.of(context).colorScheme.primary
  );
}
