// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginSubtitle => 'Welcome back! Sign in to continue';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get invalidPhoneNumber => 'Invalid phone number';

  @override
  String get login => 'Login';

  @override
  String get or => 'OR';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get createAccount => 'Create account';

  @override
  String authFailed(String method) {
    return '$method failed. Please check your details and try again.';
  }

  @override
  String get createAccountSubtitle => 'Enter your details to create a new account';

  @override
  String get name => 'Name';

  @override
  String get nameIsRequired => 'Name is required';

  @override
  String get phoneIsRequired => 'Phone number is required';

  @override
  String get addressIsRequired => 'Address is required';

  @override
  String get enterFullName => 'Enter your full name';

  @override
  String get enterPhoneNumber => 'Enter your phone number';

  @override
  String get address => 'Address';

  @override
  String get enterAddress => 'Enter your address';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get termsAgreementPrefix => 'By creating an account, you agree to the';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get verifyPhoneNumber => 'Verify Mobile Number';

  @override
  String get enterVerificationCode => 'Enter the verification code sent to';

  @override
  String get changeNumber => 'Change number';

  @override
  String get didntReceiveCode => 'Didn\'t receive the code?';

  @override
  String get resendCode => 'Resend code';

  @override
  String get resendCodeIn => 'Resend code in';

  @override
  String get confirm => 'Confirm';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get otpErrorTitle => 'Mobile Number Verification Failed';

  @override
  String get otpErrorMessage => 'The code you entered is incorrect.\nPlease try again.';

  @override
  String get searchFoodDrinks => 'Search for food, drinks...';

  @override
  String get burgers => 'Burgers';

  @override
  String get strips => 'Strips';

  @override
  String get pizza => 'Pizza';

  @override
  String get meals => 'Meals';

  @override
  String get drinks => 'Drinks';

  @override
  String get sides => 'Sides';

  @override
  String get chooseFavoriteBurger => 'Choose your favorite burger';

  @override
  String get popularItem => 'Popular Item';

  @override
  String get viewAll => 'View All';

  @override
  String get viewCart => 'View cart';

  @override
  String itemCount(int count) {
    return '$count item';
  }

  @override
  String get home => 'Home';

  @override
  String get orders => 'Orders';

  @override
  String get profile => 'Profile';

  @override
  String get cart => 'Cart';

  @override
  String get search => 'Search';

  @override
  String get classicBurger => 'Classic Burger';

  @override
  String get classicBurgerDescription => 'Beef patty, cheddar cheese, tomato, lettuce, special sauce';

  @override
  String get classicBurgerEnglishDescription => 'Beef patty, cheddar cheese, tomato, lettuce, special sauce';

  @override
  String get spicyBurger => 'Spicy Burger';

  @override
  String get spicyBurgerDescription => 'Crispy chicken, jalapeños, cheese, spicy sauce';

  @override
  String get doubleSmash => 'Double Smash';

  @override
  String get edit => 'Edit';

  @override
  String get profileName => 'Mohamed Ahmed';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get addresses => 'Addresses';

  @override
  String get favorites => 'Favorites';

  @override
  String get paymentMethods => 'Payment methods';

  @override
  String get couponsOffers => 'Coupons & offers';

  @override
  String get support => 'Support & help';

  @override
  String get shareApp => 'Share app';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Log out';

  @override
  String get noInternetTitle => 'No Internet Connection';

  @override
  String get noInternetMessage => 'It looks like you\'re offline.\nPlease check your connection and try again.';

  @override
  String get retry => 'Retry';

  @override
  String get myOrders => 'My Orders';

  @override
  String get currentOrders => 'Current Orders';

  @override
  String get previousOrders => 'Previous Orders';

  @override
  String get all => 'All';

  @override
  String get filter => 'Filter';

  @override
  String get orderNumber => 'Order number';

  @override
  String get completed => 'Completed';

  @override
  String get preparing => 'Preparing';

  @override
  String get delivered => 'Delivered';

  @override
  String get orderReceived => 'Order received';

  @override
  String get deliveryTo => 'Delivery to';

  @override
  String get showDetails => 'View details';

  @override
  String get reorder => 'Reorder';

  @override
  String get trackOrder => 'Track order';

  @override
  String get total => 'Total';

  @override
  String get noNewOrdersTitle => 'No Recent Orders';

  @override
  String get noNewOrdersMessage => 'When you place an order, it will appear here.';

  @override
  String get checkout => 'Payment';

  @override
  String get delivery => 'Delivery';

  @override
  String get payment => 'Payment';

  @override
  String get choosePaymentMethod => 'Choose a payment method';

  @override
  String get cashOnDelivery => 'Cash on Delivery';

  @override
  String get cashOnDeliveryDescription => 'Pay in cash when you receive your order';

  @override
  String get visaMastercard => 'Visa / Mastercard';

  @override
  String get cardPaymentDescription => 'Pay securely using your credit or debit card';

  @override
  String get instapay => 'InstaPay';

  @override
  String get instapayDescription => 'Pay easily and instantly using your InstaPay account';

  @override
  String get productsSubtotal => 'Products total';

  @override
  String get deliveryFee => 'Delivery fee';

  @override
  String get discount => 'Discount';

  @override
  String get grandTotal => 'Total';

  @override
  String get confirmOrder => 'Confirm order';

  @override
  String get securePaymentInfo => 'Your payment information is secure and encrypted';

  @override
  String get continueToPayment => 'Continue to Payment';

  @override
  String get resumePayment => 'Continue to Payment';

  @override
  String get deliveryTitle => 'Delivery';

  @override
  String get chooseMethod => 'Choose method';

  @override
  String get homeDelivery => 'Home delivery';

  @override
  String get branchPickup => 'Branch pickup';

  @override
  String get chooseTime => 'Choose time:';

  @override
  String get pickupFrom => 'Pickup from:';

  @override
  String get pickupTime => 'Pickup time';

  @override
  String get pickupLocation => 'Pickup location';

  @override
  String get chooseAddress => 'Choose address:';

  @override
  String get changeAddress => 'Change address';

  @override
  String get addNewAddress => 'Add new address';

  @override
  String get confirmLocation => 'Confirm location';

  @override
  String get selectYourLocation => 'Select your location';

  @override
  String get searchPlaceAddress => 'Search for a place or address';

  @override
  String get confirmAddress => 'Confirm Address';

  @override
  String get regionName => 'Region name';

  @override
  String get searchOrChooseRegion => 'Choose or search for your region';

  @override
  String get streetName => 'Street name';

  @override
  String get enterStreetName => 'Enter street name';

  @override
  String get landmark => 'Landmark';

  @override
  String get landmarkExample => 'Example: In front of Banque Misr, next to a school...';

  @override
  String get buildingNumber => 'House / building number';

  @override
  String get buildingNumberExample => 'Example: 123';

  @override
  String get floor => 'Floor';

  @override
  String get floorExample => 'Example: 3';

  @override
  String get apartmentNumber => 'Apartment number';

  @override
  String get apartmentExample => 'Example: 7';

  @override
  String get additionalNotes => 'Additional notes';

  @override
  String get additionalNotesHint => 'Write any details that will help us reach you...';

  @override
  String get setAsDefaultAddress => 'Set as default address';

  @override
  String get defaultAddressDescription => 'This address will be used for every order.';

  @override
  String get productOptionsDescription => 'A fried or baked sweet made from sweet dough, usually covered with sugar or chocolate.';

  @override
  String get chooseOptions => 'Choose from the options:';

  @override
  String get required => 'Required';

  @override
  String get chooseOne => 'Choose 1';

  @override
  String get paidAdditions => 'Paid Additions';

  @override
  String get freeAdditions => 'Free Additions';

  @override
  String get optional => 'optional';

  @override
  String get mandatory => 'mandatory';

  @override
  String get powderedSugar => 'Powdered sugar';

  @override
  String get whiteChocolate => 'White chocolate';

  @override
  String get pistachio => 'Crushed pistachio';

  @override
  String get chooseQuantityToAdd => 'Choose the quantity to add the product';

  @override
  String get addToOrder => 'Add to order';

  @override
  String get cartView => 'View cart';

  @override
  String get notifications => 'Notifications';

  @override
  String get updates => 'Updates';

  @override
  String get offers => 'Offers';

  @override
  String get notificationOrders => 'Orders';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get orderConfirmedNotification => 'Your order is confirmed';

  @override
  String orderConfirmedMessage(String orderNumber) {
    return 'Your order #$orderNumber has been confirmed and is being prepared.';
  }

  @override
  String get orderOnTheWayNotification => 'Your order is on the way';

  @override
  String orderOnTheWayMessage(String orderNumber, int minutes) {
    return 'Your order #$orderNumber is on the way and will arrive within $minutes minutes.';
  }

  @override
  String get specialOfferNotification => 'Special Offer 🎉';

  @override
  String specialOfferMessage(int discount) {
    return '$discount% off all orders from today until the end of the week!';
  }

  @override
  String get orderDeliveredNotification => 'Your order has been delivered';

  @override
  String orderDeliveredMessage(String orderNumber) {
    return 'Your order #$orderNumber was delivered successfully.';
  }

  @override
  String get appUpdateNotification => 'App Update';

  @override
  String get appUpdateMessage => 'The app has been updated to the latest version to improve your experience.';

  @override
  String get welcomeNotification => 'Welcome to our app! 👋';

  @override
  String get welcomeMessage => 'Start shopping now and discover the best offers.';

  @override
  String get noNotificationsTitle => 'No Notifications';

  @override
  String get noNotificationsMessage => 'Your new notifications will appear here.';

  @override
  String get pound => 'EGP';

  @override
  String get canceled => 'Canceled';

  @override
  String timeAgo(String time) {
    return '$time ago';
  }

  @override
  String get minute => 'A minute';

  @override
  String get twoMinutes => 'Two minutes';

  @override
  String get minutes => 'minutes';

  @override
  String get hour => 'An hour';

  @override
  String get twoHours => 'Two hours';

  @override
  String get hours => 'hours';

  @override
  String get now => 'Now';

  @override
  String get myAccount => 'My Account';

  @override
  String get version => 'Version';

  @override
  String get region => 'Region';

  @override
  String get street => 'Street';

  @override
  String get details => 'Details';

  @override
  String get apartment => 'Apartment';

  @override
  String get orderNotes => 'Order notes';

  @override
  String get orderNotesHint => 'Write your notes here...';

  @override
  String get orderNotesDescription => 'You can write any special instructions for your order (e.g., no sugar, extra sauce...)';

  @override
  String get product => 'product';

  @override
  String get egypt => 'Egypt';

  @override
  String get saudiArabia => 'Saudi Arabia';

  @override
  String get emirates => 'UAE';

  @override
  String get kuwait => 'Kuwait';

  @override
  String get register => 'Register';

  @override
  String get otpErrorSnackbarMessage => 'Verification failed. Please check the code and try again.';

  @override
  String get selectedLocation => 'Selected Location';

  @override
  String get detailedAddress => 'Detailed Address';

  @override
  String get regionIsRequired => 'Please choose a region';

  @override
  String get detailedAddressRequired => 'Please enter your detailed address';

  @override
  String get couponsSubtitle => 'Use your coupons and enjoy the best offers';

  @override
  String get couponsTab => 'Coupons';

  @override
  String get offersTab => 'Offers';

  @override
  String get enterCouponCode => 'Have a coupon code? Enter it here';

  @override
  String get apply => 'Apply';

  @override
  String get availableCoupons => 'Available coupons';

  @override
  String get expiredCoupons => 'Expired coupons';

  @override
  String get couponActive => 'Active';

  @override
  String get couponExpired => 'Expired';

  @override
  String get remainingUses => 'Remaining uses';

  @override
  String couponUsesCount(int remaining, int total) {
    return '$remaining of $total';
  }

  @override
  String get unlimited => 'Unlimited';

  @override
  String couponMinimumOrder(int amount) {
    return 'Minimum order $amount EGP';
  }

  @override
  String couponExpiresOn(String date) {
    return 'Expires on $date';
  }

  @override
  String couponExpiredOn(String date) {
    return 'Expired on $date';
  }

  @override
  String get copyCode => 'Copy code';

  @override
  String get codeCopied => 'Code copied';

  @override
  String get freeShipping => 'Free shipping';

  @override
  String get couponsInfoTitle => 'Apply coupons before payment';

  @override
  String get couponsInfoMessage => 'You cannot combine more than one coupon in a single order';

  @override
  String offerValidUntil(String date) {
    return 'Valid until $date';
  }

  @override
  String get orderNow => 'Order now';

  @override
  String get noOffersTitle => 'No offers right now';

  @override
  String get noOffersMessage => 'Stay tuned, new offers will show up here as soon as they are available.';

  @override
  String get restaurants => 'Restaurants';

  @override
  String get foods => 'Foods';

  @override
  String get favoriteRestaurantsSubtitle => 'The restaurants you added to your favorites';

  @override
  String get addNewRestaurant => 'Add new restaurant';

  @override
  String deliveryStartsFrom(int amount) {
    return 'Delivery starts from $amount EGP';
  }

  @override
  String get delete => 'Delete';

  @override
  String get noFavoritesTitle => 'No favorites yet';

  @override
  String get noFavoritesMessage => 'You can add your favorite foods to reach them quickly';

  @override
  String get account => 'Account';

  @override
  String get application => 'App';

  @override
  String get supportAndHelp => 'Support & help';

  @override
  String get accountInformation => 'Account information';

  @override
  String get accountInformationSubtitle => 'Name, phone number, email';

  @override
  String get notificationsSubtitle => 'Manage notification preferences';

  @override
  String get enableNotifications => 'Enable notifications';

  @override
  String get enableNotificationsSubtitle => 'Receive updates about your orders and offers';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'Arabic';

  @override
  String get locationSettings => 'Location';

  @override
  String get locationSettingsSubtitle => 'Manage location access';

  @override
  String get appearance => 'Appearance';

  @override
  String get appearanceSubtitle => 'Change the app theme';

  @override
  String get lightAppearance => 'Light appearance';

  @override
  String get darkAppearance => 'Dark appearance';

  @override
  String get helpCenter => 'Help center';

  @override
  String get helpCenterSubtitle => 'FAQ and support';

  @override
  String get termsAndConditionsSubtitle => 'Usage policy and terms of service';

  @override
  String get aboutApp => 'About the app';

  @override
  String get savedAddresses => 'Saved addresses';

  @override
  String get defaultLabel => 'Default';

  @override
  String get setAsDefault => 'Set as default';

  @override
  String get addressesSecured => 'All addresses are safe and encrypted';

  @override
  String get savedPaymentMethods => 'Saved payment methods';

  @override
  String get addNewPaymentMethod => 'Add new payment method';

  @override
  String get paymentMethodsSecured => 'All payment information is safe and encrypted';

  @override
  String lastUpdated(String date) {
    return 'Last updated: $date';
  }

  @override
  String get termsIntro => 'Welcome to our app. By using the app, you agree to be bound by these terms and conditions. Please read them carefully before using the service.';

  @override
  String get termsAcceptanceTitle => 'Acceptance of terms';

  @override
  String get termsAcceptanceBody => 'By using this app, you agree to these terms and conditions and to all applicable policies and guidelines. If you do not agree to any part of these terms, please do not use the app.';

  @override
  String get termsServiceUsageTitle => 'Use of the service';

  @override
  String get termsServiceUsageBody => 'You must use the app for lawful purposes only and in a way that complies with these terms and conditions. You agree not to use the app in any way that could affect its performance or cause harm to the app or to other users.';

  @override
  String get termsUserAccountTitle => 'User account';

  @override
  String get termsUserAccountBody => 'You may need to create an account to use some of the app features. You are responsible for keeping your account information confidential and for all activity that happens through your account.';

  @override
  String get termsOrdersAndPaymentTitle => 'Orders and payment';

  @override
  String get termsOrdersAndPaymentBody => 'All orders are subject to availability and prices may change without prior notice. All due amounts must be paid before the order is confirmed.';

  @override
  String get termsCancellationTitle => 'Order cancellation and refunds';

  @override
  String get termsCancellationBody => 'You can cancel your order before preparation starts. Once preparation has started, the order cannot be cancelled and the paid amount cannot be refunded except in accordance with our refund policy.';

  @override
  String get termsChangesTitle => 'Changes to the terms';

  @override
  String get termsChangesBody => 'We reserve the right to modify these terms and conditions at any time. You will be notified of any changes through the app. Continuing to use the app after a change means you accept the new terms.';

  @override
  String get termsContactTitle => 'Contact us';

  @override
  String get termsContactBody => 'If you have any questions or enquiries about these terms and conditions, you can contact us through the support page in the app.';

  @override
  String get agreeToTermsPrefix => 'I have read and agree to the';

  @override
  String get agree => 'Agree';

  @override
  String get privacyHeroTitle => 'Your privacy matters to us';

  @override
  String get privacyHeroMessage => 'We are committed to protecting your personal data and using it safely and responsibly';

  @override
  String get privacyIntro => 'This policy explains how we collect, use and protect your personal data when you use our app and services.';

  @override
  String get privacyCollectedDataTitle => 'Information we collect';

  @override
  String get privacyCollectedDataBody => 'We collect the information you give us directly, such as your name, phone number and address, in addition to order and payment information when you use the app.';

  @override
  String get privacyDataUsageTitle => 'How we use your information';

  @override
  String get privacyDataUsageBody => 'We use your information to provide and improve our services, process orders and payments, communicate with you, and provide technical support and suitable recommendations.';

  @override
  String get privacyDataSharingTitle => 'Sharing information';

  @override
  String get privacyDataSharingBody => 'We do not sell or rent your personal data to any third party. We may share your data with service providers only to fulfil orders and payments.';

  @override
  String get privacyDataProtectionTitle => 'Data protection';

  @override
  String get privacyDataProtectionBody => 'We apply strict security standards to protect your data from unauthorised access, modification, disclosure or destruction.';

  @override
  String get privacyYourRightsTitle => 'Your rights';

  @override
  String get privacyYourRightsBody => 'You have the right to access, modify or delete your personal data at any time through your account settings or by contacting us.';

  @override
  String get privacyChangesTitle => 'Changes to the policy';

  @override
  String get privacyChangesBody => 'We may update this privacy policy from time to time. You will be notified of any important changes through the app.';

  @override
  String get supportHeroTitle => 'How can we help you?';

  @override
  String get supportHeroMessage => 'Choose the topic you need help with';

  @override
  String get orderIssue => 'Order issue';

  @override
  String get followOrder => 'Follow the order';

  @override
  String get lateOrder => 'Order is late';

  @override
  String get wrongOrMissingItem => 'Missing or wrong item';

  @override
  String get paymentIssue => 'Payment issue';

  @override
  String get paymentNotConfirmed => 'Payment was not confirmed';

  @override
  String get refund => 'Refund';

  @override
  String get editAccountData => 'Edit account data';

  @override
  String get loginIssue => 'Login issue';

  @override
  String get contactUs => 'Contact us';

  @override
  String get contactUsMessage => 'Did not find what you are looking for? We are here to help';

  @override
  String get chatWithSupport => 'Chat with support';

  @override
  String get supportHours => 'Available daily from 10 AM to 12 midnight';

  @override
  String get processingYourOrder => 'Processing your order';

  @override
  String get enterInstaPayUsername => 'Enter your InstaPay username without @instapay';

  @override
  String get requiredField => 'Required field';

  @override
  String get invalidUserName => 'Invalid username';

  @override
  String get confirmPayment => 'Confirm Payment';

  @override
  String get yourCurrentBalance => 'Your current balance';

  @override
  String get enterWalletNumber => 'Enter the wallet number you will send from';

  @override
  String get sendMoneyToNumber => 'Send the money to this number';

  @override
  String get vodafoneCash => 'Vodafone Cash';

  @override
  String get unknownError => 'Uknown Error';

  @override
  String get notificationSettings => 'Notification Settings';
}
