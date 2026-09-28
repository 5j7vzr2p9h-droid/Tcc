import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Sign in to continue'**
  String get loginSubtitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumber;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @authFailed.
  ///
  /// In en, this message translates to:
  /// **'{method} failed. Please check your details and try again.'**
  String authFailed(String method);

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your details to create a new account'**
  String get createAccountSubtitle;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameIsRequired;

  /// No description provided for @phoneIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneIsRequired;

  /// No description provided for @addressIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Address is required'**
  String get addressIsRequired;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get enterAddress;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @termsAgreementPrefix.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you agree to the'**
  String get termsAgreementPrefix;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @verifyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify Mobile Number'**
  String get verifyPhoneNumber;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to'**
  String get enterVerificationCode;

  /// No description provided for @changeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get changeNumber;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didntReceiveCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in'**
  String get resendCodeIn;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @otpErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number Verification Failed'**
  String get otpErrorTitle;

  /// No description provided for @otpErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The code you entered is incorrect.\nPlease try again.'**
  String get otpErrorMessage;

  /// No description provided for @searchFoodDrinks.
  ///
  /// In en, this message translates to:
  /// **'Search for food, drinks...'**
  String get searchFoodDrinks;

  /// No description provided for @burgers.
  ///
  /// In en, this message translates to:
  /// **'Burgers'**
  String get burgers;

  /// No description provided for @strips.
  ///
  /// In en, this message translates to:
  /// **'Strips'**
  String get strips;

  /// No description provided for @pizza.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get pizza;

  /// No description provided for @meals.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get meals;

  /// No description provided for @drinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get drinks;

  /// No description provided for @sides.
  ///
  /// In en, this message translates to:
  /// **'Sides'**
  String get sides;

  /// No description provided for @chooseFavoriteBurger.
  ///
  /// In en, this message translates to:
  /// **'Choose your favorite burger'**
  String get chooseFavoriteBurger;

  /// No description provided for @popularItem.
  ///
  /// In en, this message translates to:
  /// **'Popular Item'**
  String get popularItem;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get viewCart;

  /// Number of items shown in the cart bar
  ///
  /// In en, this message translates to:
  /// **'{count} item'**
  String itemCount(int count);

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @classicBurger.
  ///
  /// In en, this message translates to:
  /// **'Classic Burger'**
  String get classicBurger;

  /// No description provided for @classicBurgerDescription.
  ///
  /// In en, this message translates to:
  /// **'Beef patty, cheddar cheese, tomato, lettuce, special sauce'**
  String get classicBurgerDescription;

  /// No description provided for @classicBurgerEnglishDescription.
  ///
  /// In en, this message translates to:
  /// **'Beef patty, cheddar cheese, tomato, lettuce, special sauce'**
  String get classicBurgerEnglishDescription;

  /// No description provided for @spicyBurger.
  ///
  /// In en, this message translates to:
  /// **'Spicy Burger'**
  String get spicyBurger;

  /// No description provided for @spicyBurgerDescription.
  ///
  /// In en, this message translates to:
  /// **'Crispy chicken, jalapeños, cheese, spicy sauce'**
  String get spicyBurgerDescription;

  /// No description provided for @doubleSmash.
  ///
  /// In en, this message translates to:
  /// **'Double Smash'**
  String get doubleSmash;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Mohamed Ahmed'**
  String get profileName;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @addresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addresses;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get paymentMethods;

  /// No description provided for @couponsOffers.
  ///
  /// In en, this message translates to:
  /// **'Coupons & offers'**
  String get couponsOffers;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support & help'**
  String get support;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share app'**
  String get shareApp;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @noInternetTitle.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetTitle;

  /// No description provided for @noInternetMessage.
  ///
  /// In en, this message translates to:
  /// **'It looks like you\'re offline.\nPlease check your connection and try again.'**
  String get noInternetMessage;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @currentOrders.
  ///
  /// In en, this message translates to:
  /// **'Current Orders'**
  String get currentOrders;

  /// No description provided for @previousOrders.
  ///
  /// In en, this message translates to:
  /// **'Previous Orders'**
  String get previousOrders;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order number'**
  String get orderNumber;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @preparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get preparing;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @orderReceived.
  ///
  /// In en, this message translates to:
  /// **'Order received'**
  String get orderReceived;

  /// No description provided for @deliveryTo.
  ///
  /// In en, this message translates to:
  /// **'Delivery to'**
  String get deliveryTo;

  /// No description provided for @showDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get showDetails;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// No description provided for @trackOrder.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get trackOrder;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @noNewOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'No Recent Orders'**
  String get noNewOrdersTitle;

  /// No description provided for @noNewOrdersMessage.
  ///
  /// In en, this message translates to:
  /// **'When you place an order, it will appear here.'**
  String get noNewOrdersMessage;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get checkout;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @choosePaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose a payment method'**
  String get choosePaymentMethod;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @cashOnDeliveryDescription.
  ///
  /// In en, this message translates to:
  /// **'Pay in cash when you receive your order'**
  String get cashOnDeliveryDescription;

  /// No description provided for @visaMastercard.
  ///
  /// In en, this message translates to:
  /// **'Visa / Mastercard'**
  String get visaMastercard;

  /// No description provided for @cardPaymentDescription.
  ///
  /// In en, this message translates to:
  /// **'Pay securely using your credit or debit card'**
  String get cardPaymentDescription;

  /// No description provided for @instapay.
  ///
  /// In en, this message translates to:
  /// **'InstaPay'**
  String get instapay;

  /// No description provided for @instapayDescription.
  ///
  /// In en, this message translates to:
  /// **'Pay easily and instantly using your InstaPay account'**
  String get instapayDescription;

  /// No description provided for @productsSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Products total'**
  String get productsSubtotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee'**
  String get deliveryFee;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @grandTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get grandTotal;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm order'**
  String get confirmOrder;

  /// No description provided for @securePaymentInfo.
  ///
  /// In en, this message translates to:
  /// **'Your payment information is secure and encrypted'**
  String get securePaymentInfo;

  /// No description provided for @continueToPayment.
  ///
  /// In en, this message translates to:
  /// **'Continue to Payment'**
  String get continueToPayment;

  /// No description provided for @resumePayment.
  ///
  /// In en, this message translates to:
  /// **'Continue to Payment'**
  String get resumePayment;

  /// No description provided for @deliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryTitle;

  /// No description provided for @chooseMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose method'**
  String get chooseMethod;

  /// No description provided for @homeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Home delivery'**
  String get homeDelivery;

  /// No description provided for @branchPickup.
  ///
  /// In en, this message translates to:
  /// **'Branch pickup'**
  String get branchPickup;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose time:'**
  String get chooseTime;

  /// No description provided for @pickupFrom.
  ///
  /// In en, this message translates to:
  /// **'Pickup from:'**
  String get pickupFrom;

  /// No description provided for @pickupTime.
  ///
  /// In en, this message translates to:
  /// **'Pickup time'**
  String get pickupTime;

  /// No description provided for @pickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup location'**
  String get pickupLocation;

  /// No description provided for @chooseAddress.
  ///
  /// In en, this message translates to:
  /// **'Choose address:'**
  String get chooseAddress;

  /// No description provided for @changeAddress.
  ///
  /// In en, this message translates to:
  /// **'Change address'**
  String get changeAddress;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add new address'**
  String get addNewAddress;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm location'**
  String get confirmLocation;

  /// No description provided for @selectYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Select your location'**
  String get selectYourLocation;

  /// No description provided for @searchPlaceAddress.
  ///
  /// In en, this message translates to:
  /// **'Search for a place or address'**
  String get searchPlaceAddress;

  /// No description provided for @confirmAddress.
  ///
  /// In en, this message translates to:
  /// **'Confirm Address'**
  String get confirmAddress;

  /// No description provided for @regionName.
  ///
  /// In en, this message translates to:
  /// **'Region name'**
  String get regionName;

  /// No description provided for @searchOrChooseRegion.
  ///
  /// In en, this message translates to:
  /// **'Choose or search for your region'**
  String get searchOrChooseRegion;

  /// No description provided for @streetName.
  ///
  /// In en, this message translates to:
  /// **'Street name'**
  String get streetName;

  /// No description provided for @enterStreetName.
  ///
  /// In en, this message translates to:
  /// **'Enter street name'**
  String get enterStreetName;

  /// No description provided for @landmark.
  ///
  /// In en, this message translates to:
  /// **'Landmark'**
  String get landmark;

  /// No description provided for @landmarkExample.
  ///
  /// In en, this message translates to:
  /// **'Example: In front of Banque Misr, next to a school...'**
  String get landmarkExample;

  /// No description provided for @buildingNumber.
  ///
  /// In en, this message translates to:
  /// **'House / building number'**
  String get buildingNumber;

  /// No description provided for @buildingNumberExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 123'**
  String get buildingNumberExample;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

  /// No description provided for @floorExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 3'**
  String get floorExample;

  /// No description provided for @apartmentNumber.
  ///
  /// In en, this message translates to:
  /// **'Apartment number'**
  String get apartmentNumber;

  /// No description provided for @apartmentExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 7'**
  String get apartmentExample;

  /// No description provided for @additionalNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional notes'**
  String get additionalNotes;

  /// No description provided for @additionalNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Write any details that will help us reach you...'**
  String get additionalNotesHint;

  /// No description provided for @setAsDefaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Set as default address'**
  String get setAsDefaultAddress;

  /// No description provided for @defaultAddressDescription.
  ///
  /// In en, this message translates to:
  /// **'This address will be used for every order.'**
  String get defaultAddressDescription;

  /// No description provided for @productOptionsDescription.
  ///
  /// In en, this message translates to:
  /// **'A fried or baked sweet made from sweet dough, usually covered with sugar or chocolate.'**
  String get productOptionsDescription;

  /// No description provided for @chooseOptions.
  ///
  /// In en, this message translates to:
  /// **'Choose from the options:'**
  String get chooseOptions;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @chooseOne.
  ///
  /// In en, this message translates to:
  /// **'Choose 1'**
  String get chooseOne;

  /// No description provided for @paidAdditions.
  ///
  /// In en, this message translates to:
  /// **'Paid Additions'**
  String get paidAdditions;

  /// No description provided for @freeAdditions.
  ///
  /// In en, this message translates to:
  /// **'Free Additions'**
  String get freeAdditions;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get optional;

  /// No description provided for @mandatory.
  ///
  /// In en, this message translates to:
  /// **'mandatory'**
  String get mandatory;

  /// No description provided for @powderedSugar.
  ///
  /// In en, this message translates to:
  /// **'Powdered sugar'**
  String get powderedSugar;

  /// No description provided for @whiteChocolate.
  ///
  /// In en, this message translates to:
  /// **'White chocolate'**
  String get whiteChocolate;

  /// No description provided for @pistachio.
  ///
  /// In en, this message translates to:
  /// **'Crushed pistachio'**
  String get pistachio;

  /// No description provided for @chooseQuantityToAdd.
  ///
  /// In en, this message translates to:
  /// **'Choose the quantity to add the product'**
  String get chooseQuantityToAdd;

  /// No description provided for @addToOrder.
  ///
  /// In en, this message translates to:
  /// **'Add to order'**
  String get addToOrder;

  /// No description provided for @cartView.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get cartView;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @notificationOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get notificationOrders;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @orderConfirmedNotification.
  ///
  /// In en, this message translates to:
  /// **'Your order is confirmed'**
  String get orderConfirmedNotification;

  /// No description provided for @orderConfirmedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your order #{orderNumber} has been confirmed and is being prepared.'**
  String orderConfirmedMessage(String orderNumber);

  /// No description provided for @orderOnTheWayNotification.
  ///
  /// In en, this message translates to:
  /// **'Your order is on the way'**
  String get orderOnTheWayNotification;

  /// No description provided for @orderOnTheWayMessage.
  ///
  /// In en, this message translates to:
  /// **'Your order #{orderNumber} is on the way and will arrive within {minutes} minutes.'**
  String orderOnTheWayMessage(String orderNumber, int minutes);

  /// No description provided for @specialOfferNotification.
  ///
  /// In en, this message translates to:
  /// **'Special Offer 🎉'**
  String get specialOfferNotification;

  /// No description provided for @specialOfferMessage.
  ///
  /// In en, this message translates to:
  /// **'{discount}% off all orders from today until the end of the week!'**
  String specialOfferMessage(int discount);

  /// No description provided for @orderDeliveredNotification.
  ///
  /// In en, this message translates to:
  /// **'Your order has been delivered'**
  String get orderDeliveredNotification;

  /// No description provided for @orderDeliveredMessage.
  ///
  /// In en, this message translates to:
  /// **'Your order #{orderNumber} was delivered successfully.'**
  String orderDeliveredMessage(String orderNumber);

  /// No description provided for @appUpdateNotification.
  ///
  /// In en, this message translates to:
  /// **'App Update'**
  String get appUpdateNotification;

  /// No description provided for @appUpdateMessage.
  ///
  /// In en, this message translates to:
  /// **'The app has been updated to the latest version to improve your experience.'**
  String get appUpdateMessage;

  /// No description provided for @welcomeNotification.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our app! 👋'**
  String get welcomeNotification;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Start shopping now and discover the best offers.'**
  String get welcomeMessage;

  /// No description provided for @noNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get noNotificationsTitle;

  /// No description provided for @noNotificationsMessage.
  ///
  /// In en, this message translates to:
  /// **'Your new notifications will appear here.'**
  String get noNotificationsMessage;

  /// No description provided for @pound.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get pound;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @timeAgo.
  ///
  /// In en, this message translates to:
  /// **'{time} ago'**
  String timeAgo(String time);

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'A minute'**
  String get minute;

  /// No description provided for @twoMinutes.
  ///
  /// In en, this message translates to:
  /// **'Two minutes'**
  String get twoMinutes;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'An hour'**
  String get hour;

  /// No description provided for @twoHours.
  ///
  /// In en, this message translates to:
  /// **'Two hours'**
  String get twoHours;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartment;

  /// No description provided for @orderNotes.
  ///
  /// In en, this message translates to:
  /// **'Order notes'**
  String get orderNotes;

  /// No description provided for @orderNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Write your notes here...'**
  String get orderNotesHint;

  /// No description provided for @orderNotesDescription.
  ///
  /// In en, this message translates to:
  /// **'You can write any special instructions for your order (e.g., no sugar, extra sauce...)'**
  String get orderNotesDescription;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'product'**
  String get product;

  /// No description provided for @egypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get egypt;

  /// No description provided for @saudiArabia.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get saudiArabia;

  /// No description provided for @emirates.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get emirates;

  /// No description provided for @kuwait.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get kuwait;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @otpErrorSnackbarMessage.
  ///
  /// In en, this message translates to:
  /// **'Verification failed. Please check the code and try again.'**
  String get otpErrorSnackbarMessage;

  /// No description provided for @selectedLocation.
  ///
  /// In en, this message translates to:
  /// **'Selected Location'**
  String get selectedLocation;

  /// No description provided for @detailedAddress.
  ///
  /// In en, this message translates to:
  /// **'Detailed Address'**
  String get detailedAddress;

  /// No description provided for @regionIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please choose a region'**
  String get regionIsRequired;

  /// No description provided for @detailedAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your detailed address'**
  String get detailedAddressRequired;

  /// No description provided for @couponsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your coupons and enjoy the best offers'**
  String get couponsSubtitle;

  /// No description provided for @couponsTab.
  ///
  /// In en, this message translates to:
  /// **'Coupons'**
  String get couponsTab;

  /// No description provided for @offersTab.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offersTab;

  /// No description provided for @enterCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Have a coupon code? Enter it here'**
  String get enterCouponCode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @availableCoupons.
  ///
  /// In en, this message translates to:
  /// **'Available coupons'**
  String get availableCoupons;

  /// No description provided for @expiredCoupons.
  ///
  /// In en, this message translates to:
  /// **'Expired coupons'**
  String get expiredCoupons;

  /// No description provided for @couponActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get couponActive;

  /// No description provided for @couponExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get couponExpired;

  /// No description provided for @remainingUses.
  ///
  /// In en, this message translates to:
  /// **'Remaining uses'**
  String get remainingUses;

  /// No description provided for @couponUsesCount.
  ///
  /// In en, this message translates to:
  /// **'{remaining} of {total}'**
  String couponUsesCount(int remaining, int total);

  /// No description provided for @unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited;

  /// No description provided for @couponMinimumOrder.
  ///
  /// In en, this message translates to:
  /// **'Minimum order {amount} EGP'**
  String couponMinimumOrder(int amount);

  /// No description provided for @couponExpiresOn.
  ///
  /// In en, this message translates to:
  /// **'Expires on {date}'**
  String couponExpiresOn(String date);

  /// No description provided for @couponExpiredOn.
  ///
  /// In en, this message translates to:
  /// **'Expired on {date}'**
  String couponExpiredOn(String date);

  /// No description provided for @copyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get copyCode;

  /// No description provided for @codeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied'**
  String get codeCopied;

  /// No description provided for @freeShipping.
  ///
  /// In en, this message translates to:
  /// **'Free shipping'**
  String get freeShipping;

  /// No description provided for @couponsInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply coupons before payment'**
  String get couponsInfoTitle;

  /// No description provided for @couponsInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'You cannot combine more than one coupon in a single order'**
  String get couponsInfoMessage;

  /// No description provided for @offerValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String offerValidUntil(String date);

  /// No description provided for @orderNow.
  ///
  /// In en, this message translates to:
  /// **'Order now'**
  String get orderNow;

  /// No description provided for @noOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'No offers right now'**
  String get noOffersTitle;

  /// No description provided for @noOffersMessage.
  ///
  /// In en, this message translates to:
  /// **'Stay tuned, new offers will show up here as soon as they are available.'**
  String get noOffersMessage;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @foods.
  ///
  /// In en, this message translates to:
  /// **'Foods'**
  String get foods;

  /// No description provided for @favoriteRestaurantsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The restaurants you added to your favorites'**
  String get favoriteRestaurantsSubtitle;

  /// No description provided for @addNewRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Add new restaurant'**
  String get addNewRestaurant;

  /// No description provided for @deliveryStartsFrom.
  ///
  /// In en, this message translates to:
  /// **'Delivery starts from {amount} EGP'**
  String deliveryStartsFrom(int amount);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @noFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavoritesTitle;

  /// No description provided for @noFavoritesMessage.
  ///
  /// In en, this message translates to:
  /// **'You can add your favorite foods to reach them quickly'**
  String get noFavoritesMessage;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get application;

  /// No description provided for @supportAndHelp.
  ///
  /// In en, this message translates to:
  /// **'Support & help'**
  String get supportAndHelp;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account information'**
  String get accountInformation;

  /// No description provided for @accountInformationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, phone number, email'**
  String get accountInformationSubtitle;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage notification preferences'**
  String get notificationsSubtitle;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get enableNotifications;

  /// No description provided for @enableNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive updates about your orders and offers'**
  String get enableNotificationsSubtitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @locationSettings.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationSettings;

  /// No description provided for @locationSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage location access'**
  String get locationSettingsSubtitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @appearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change the app theme'**
  String get appearanceSubtitle;

  /// No description provided for @lightAppearance.
  ///
  /// In en, this message translates to:
  /// **'Light appearance'**
  String get lightAppearance;

  /// No description provided for @darkAppearance.
  ///
  /// In en, this message translates to:
  /// **'Dark appearance'**
  String get darkAppearance;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get helpCenter;

  /// No description provided for @helpCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ and support'**
  String get helpCenterSubtitle;

  /// No description provided for @termsAndConditionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Usage policy and terms of service'**
  String get termsAndConditionsSubtitle;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get aboutApp;

  /// No description provided for @savedAddresses.
  ///
  /// In en, this message translates to:
  /// **'Saved addresses'**
  String get savedAddresses;

  /// No description provided for @defaultLabel.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultLabel;

  /// No description provided for @setAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get setAsDefault;

  /// No description provided for @addressesSecured.
  ///
  /// In en, this message translates to:
  /// **'All addresses are safe and encrypted'**
  String get addressesSecured;

  /// No description provided for @savedPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Saved payment methods'**
  String get savedPaymentMethods;

  /// No description provided for @addNewPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Add new payment method'**
  String get addNewPaymentMethod;

  /// No description provided for @paymentMethodsSecured.
  ///
  /// In en, this message translates to:
  /// **'All payment information is safe and encrypted'**
  String get paymentMethodsSecured;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String lastUpdated(String date);

  /// No description provided for @termsIntro.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our app. By using the app, you agree to be bound by these terms and conditions. Please read them carefully before using the service.'**
  String get termsIntro;

  /// No description provided for @termsAcceptanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Acceptance of terms'**
  String get termsAcceptanceTitle;

  /// No description provided for @termsAcceptanceBody.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to these terms and conditions and to all applicable policies and guidelines. If you do not agree to any part of these terms, please do not use the app.'**
  String get termsAcceptanceBody;

  /// No description provided for @termsServiceUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'Use of the service'**
  String get termsServiceUsageTitle;

  /// No description provided for @termsServiceUsageBody.
  ///
  /// In en, this message translates to:
  /// **'You must use the app for lawful purposes only and in a way that complies with these terms and conditions. You agree not to use the app in any way that could affect its performance or cause harm to the app or to other users.'**
  String get termsServiceUsageBody;

  /// No description provided for @termsUserAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'User account'**
  String get termsUserAccountTitle;

  /// No description provided for @termsUserAccountBody.
  ///
  /// In en, this message translates to:
  /// **'You may need to create an account to use some of the app features. You are responsible for keeping your account information confidential and for all activity that happens through your account.'**
  String get termsUserAccountBody;

  /// No description provided for @termsOrdersAndPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Orders and payment'**
  String get termsOrdersAndPaymentTitle;

  /// No description provided for @termsOrdersAndPaymentBody.
  ///
  /// In en, this message translates to:
  /// **'All orders are subject to availability and prices may change without prior notice. All due amounts must be paid before the order is confirmed.'**
  String get termsOrdersAndPaymentBody;

  /// No description provided for @termsCancellationTitle.
  ///
  /// In en, this message translates to:
  /// **'Order cancellation and refunds'**
  String get termsCancellationTitle;

  /// No description provided for @termsCancellationBody.
  ///
  /// In en, this message translates to:
  /// **'You can cancel your order before preparation starts. Once preparation has started, the order cannot be cancelled and the paid amount cannot be refunded except in accordance with our refund policy.'**
  String get termsCancellationBody;

  /// No description provided for @termsChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes to the terms'**
  String get termsChangesTitle;

  /// No description provided for @termsChangesBody.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to modify these terms and conditions at any time. You will be notified of any changes through the app. Continuing to use the app after a change means you accept the new terms.'**
  String get termsChangesBody;

  /// No description provided for @termsContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get termsContactTitle;

  /// No description provided for @termsContactBody.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions or enquiries about these terms and conditions, you can contact us through the support page in the app.'**
  String get termsContactBody;

  /// No description provided for @agreeToTermsPrefix.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to the'**
  String get agreeToTermsPrefix;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @privacyHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Your privacy matters to us'**
  String get privacyHeroTitle;

  /// No description provided for @privacyHeroMessage.
  ///
  /// In en, this message translates to:
  /// **'We are committed to protecting your personal data and using it safely and responsibly'**
  String get privacyHeroMessage;

  /// No description provided for @privacyIntro.
  ///
  /// In en, this message translates to:
  /// **'This policy explains how we collect, use and protect your personal data when you use our app and services.'**
  String get privacyIntro;

  /// No description provided for @privacyCollectedDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Information we collect'**
  String get privacyCollectedDataTitle;

  /// No description provided for @privacyCollectedDataBody.
  ///
  /// In en, this message translates to:
  /// **'We collect the information you give us directly, such as your name, phone number and address, in addition to order and payment information when you use the app.'**
  String get privacyCollectedDataBody;

  /// No description provided for @privacyDataUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'How we use your information'**
  String get privacyDataUsageTitle;

  /// No description provided for @privacyDataUsageBody.
  ///
  /// In en, this message translates to:
  /// **'We use your information to provide and improve our services, process orders and payments, communicate with you, and provide technical support and suitable recommendations.'**
  String get privacyDataUsageBody;

  /// No description provided for @privacyDataSharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Sharing information'**
  String get privacyDataSharingTitle;

  /// No description provided for @privacyDataSharingBody.
  ///
  /// In en, this message translates to:
  /// **'We do not sell or rent your personal data to any third party. We may share your data with service providers only to fulfil orders and payments.'**
  String get privacyDataSharingBody;

  /// No description provided for @privacyDataProtectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Data protection'**
  String get privacyDataProtectionTitle;

  /// No description provided for @privacyDataProtectionBody.
  ///
  /// In en, this message translates to:
  /// **'We apply strict security standards to protect your data from unauthorised access, modification, disclosure or destruction.'**
  String get privacyDataProtectionBody;

  /// No description provided for @privacyYourRightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your rights'**
  String get privacyYourRightsTitle;

  /// No description provided for @privacyYourRightsBody.
  ///
  /// In en, this message translates to:
  /// **'You have the right to access, modify or delete your personal data at any time through your account settings or by contacting us.'**
  String get privacyYourRightsBody;

  /// No description provided for @privacyChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes to the policy'**
  String get privacyChangesTitle;

  /// No description provided for @privacyChangesBody.
  ///
  /// In en, this message translates to:
  /// **'We may update this privacy policy from time to time. You will be notified of any important changes through the app.'**
  String get privacyChangesBody;

  /// No description provided for @supportHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get supportHeroTitle;

  /// No description provided for @supportHeroMessage.
  ///
  /// In en, this message translates to:
  /// **'Choose the topic you need help with'**
  String get supportHeroMessage;

  /// No description provided for @orderIssue.
  ///
  /// In en, this message translates to:
  /// **'Order issue'**
  String get orderIssue;

  /// No description provided for @followOrder.
  ///
  /// In en, this message translates to:
  /// **'Follow the order'**
  String get followOrder;

  /// No description provided for @lateOrder.
  ///
  /// In en, this message translates to:
  /// **'Order is late'**
  String get lateOrder;

  /// No description provided for @wrongOrMissingItem.
  ///
  /// In en, this message translates to:
  /// **'Missing or wrong item'**
  String get wrongOrMissingItem;

  /// No description provided for @paymentIssue.
  ///
  /// In en, this message translates to:
  /// **'Payment issue'**
  String get paymentIssue;

  /// No description provided for @paymentNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Payment was not confirmed'**
  String get paymentNotConfirmed;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @editAccountData.
  ///
  /// In en, this message translates to:
  /// **'Edit account data'**
  String get editAccountData;

  /// No description provided for @loginIssue.
  ///
  /// In en, this message translates to:
  /// **'Login issue'**
  String get loginIssue;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @contactUsMessage.
  ///
  /// In en, this message translates to:
  /// **'Did not find what you are looking for? We are here to help'**
  String get contactUsMessage;

  /// No description provided for @chatWithSupport.
  ///
  /// In en, this message translates to:
  /// **'Chat with support'**
  String get chatWithSupport;

  /// No description provided for @supportHours.
  ///
  /// In en, this message translates to:
  /// **'Available daily from 10 AM to 12 midnight'**
  String get supportHours;

  /// No description provided for @processingYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Processing your order'**
  String get processingYourOrder;

  /// No description provided for @enterInstaPayUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter your InstaPay username without @instapay'**
  String get enterInstaPayUsername;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get requiredField;

  /// No description provided for @invalidUserName.
  ///
  /// In en, this message translates to:
  /// **'Invalid username'**
  String get invalidUserName;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

  /// No description provided for @yourCurrentBalance.
  ///
  /// In en, this message translates to:
  /// **'Your current balance'**
  String get yourCurrentBalance;

  /// No description provided for @enterWalletNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter the wallet number you will send from'**
  String get enterWalletNumber;

  /// No description provided for @sendMoneyToNumber.
  ///
  /// In en, this message translates to:
  /// **'Send the money to this number'**
  String get sendMoneyToNumber;

  /// No description provided for @vodafoneCash.
  ///
  /// In en, this message translates to:
  /// **'Vodafone Cash'**
  String get vodafoneCash;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Uknown Error'**
  String get unknownError;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
