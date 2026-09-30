// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get loginSubtitle => 'مرحباً بك! سجل الدخول للمتابعة';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get invalidPhoneNumber => 'رقم الهاتف غير صالح';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get or => 'أو';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String authFailed(String method) {
    return 'فشل $method. يرجى التحقق من بياناتك والمحاولة مرة أخرى.';
  }

  @override
  String get createAccountSubtitle => 'سجّل بياناتك لإنشاء حساب جديد';

  @override
  String get name => 'الاسم';

  @override
  String get nameIsRequired => 'الاسم مطلوب';

  @override
  String get phoneIsRequired => 'رقم الهاتف مطلوب';

  @override
  String get addressIsRequired => 'العنوان مطلوب';

  @override
  String get enterFullName => 'أدخل اسمك الكامل';

  @override
  String get enterPhoneNumber => 'أدخل رقم هاتفك';

  @override
  String get address => 'العنوان';

  @override
  String get enterAddress => 'أدخل عنوانك';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get termsAgreementPrefix => 'بإنشاء حساب، أنت توافق على';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get verifyPhoneNumber => 'تأكيد رقم الموبايل';

  @override
  String get enterVerificationCode => 'أدخل رمز التحقق المرسل إلى';

  @override
  String get changeNumber => 'تغيير الرقم';

  @override
  String get didntReceiveCode => 'لم تستلم الرمز؟';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get resendCodeIn => 'إعادة إرسال الرمز خلال';

  @override
  String get confirm => 'تأكيد';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get otpErrorTitle => 'فشل تأكيد رقم الموبايل';

  @override
  String get otpErrorMessage => 'الرمز الذي أدخلته غير صحيح.\nيرجى المحاولة مرة أخرى.';

  @override
  String get searchFoodDrinks => 'ابحث عن طعام، مشروبات، ...';

  @override
  String get burgers => 'برجر';

  @override
  String get strips => 'ستربس';

  @override
  String get pizza => 'بيتزا';

  @override
  String get meals => 'وجبات';

  @override
  String get drinks => 'مشروبات';

  @override
  String get sides => 'جانبيات';

  @override
  String get chooseFavoriteBurger => 'اختر برجر المفضل لديك';

  @override
  String get popularItem => 'الأكثر طلباً';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get viewCart => 'عرض السلة';

  @override
  String itemCount(int count) {
    return '$count منتج';
  }

  @override
  String get home => 'الرئيسية';

  @override
  String get orders => 'الطلبات';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get cart => 'السلة';

  @override
  String get search => 'البحث';

  @override
  String get classicBurger => 'كلاسيك برجر';

  @override
  String get classicBurgerDescription => 'قطعة لحم بقري، جبنة شيدر، طماطم، خس، صوص خاص';

  @override
  String get classicBurgerEnglishDescription => 'قطعة لحم بقري، جبنة شيدر، طماطم، خس، صوص خاص';

  @override
  String get spicyBurger => 'برجر حار';

  @override
  String get spicyBurgerDescription => 'دجاج مقرمش، هالبينو، جبنة، صوص حار';

  @override
  String get doubleSmash => 'دبل سماش';

  @override
  String get edit => 'تعديل';

  @override
  String get profileName => 'محمد أحمد';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get addresses => 'العناوين';

  @override
  String get favorites => 'المفضلة';

  @override
  String get paymentMethods => 'طرق الدفع';

  @override
  String get couponsOffers => 'الكوبونات والعروض';

  @override
  String get support => 'الدعم والمساعدة';

  @override
  String get shareApp => 'مشاركة التطبيق';

  @override
  String get settings => 'الإعدادات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get noInternetTitle => 'لا يوجد اتصال بالإنترنت';

  @override
  String get noInternetMessage => 'يبدو أنك غير متصل بالإنترنت.\nيرجى التحقق من اتصالك والمحاولة مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get currentOrders => 'الطلبات الحالية';

  @override
  String get previousOrders => 'الطلبات السابقة';

  @override
  String get all => 'الكل';

  @override
  String get filter => 'تصفية';

  @override
  String get orderNumber => 'رقم الطلب';

  @override
  String get completed => 'مكتمل';

  @override
  String get preparing => 'قيد التجهيز';

  @override
  String get delivered => 'تم توصيله';

  @override
  String get orderReceived => 'تم استلام الطلب';

  @override
  String get deliveryTo => 'التوصيل إلى';

  @override
  String get showDetails => 'عرض التفاصيل';

  @override
  String get reorder => 'إعادة الطلب';

  @override
  String get trackOrder => 'تتبع الطلب';

  @override
  String get total => 'المجموع';

  @override
  String get noNewOrdersTitle => 'لا توجد طلبات حديثة';

  @override
  String get noNewOrdersMessage => 'عندما تقوم بطلب، سيظهر هنا.';

  @override
  String get noPreviousOrdersTitle => 'لا توجد طلبات سابقة';

  @override
  String get checkout => 'الدفع';

  @override
  String get delivery => 'التوصيل';

  @override
  String get payment => 'الدفع';

  @override
  String get choosePaymentMethod => 'اختر طريقة الدفع';

  @override
  String get noPaymentMethods => 'لا توجد طرق دفع متاحة حالياً';

  @override
  String get cashOnDelivery => 'الدفع نقداً (عند الاستلام)';

  @override
  String get cashOnDeliveryDescription => 'ادفع نقداً عند استلام الطلب';

  @override
  String get visaMastercard => 'فيزا / ماستركارد';

  @override
  String get cardPaymentDescription => 'ادفع بأمان باستخدام بطاقتك الائتمانية أو الخصم المباشر';

  @override
  String get instapay => 'انستا باي';

  @override
  String get instapayDescription => 'ادفع بسهولة وفوراً باستخدام حسابك في انستا باي';

  @override
  String get productsSubtotal => 'إجمالي المنتجات';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get discount => 'خصم';

  @override
  String get grandTotal => 'الإجمالي';

  @override
  String get confirmOrder => 'تأكيد الطلب';

  @override
  String get securePaymentInfo => 'معلومات الدفع الخاصة بك آمنة ومشفرة';

  @override
  String get continueToPayment => 'الاستمرار إلى الدفع';

  @override
  String get resumePayment => 'متابعة الدفع';

  @override
  String get deliveryTitle => 'التوصيل';

  @override
  String get chooseMethod => 'اختر الطريقة';

  @override
  String get homeDelivery => 'توصيل للمنزل';

  @override
  String get branchPickup => 'استلام فرع';

  @override
  String get chooseTime => 'اختر الوقت:';

  @override
  String get pickupFrom => 'استلام من:';

  @override
  String get pickupTime => 'وقت الاستلام';

  @override
  String get pickupLocation => 'مكان الاستلام';

  @override
  String get chooseAddress => 'اختر العنوان:';

  @override
  String get changeAddress => 'تغيير العنوان';

  @override
  String get addNewAddress => 'إضافة عنوان جديد';

  @override
  String get confirmLocation => 'تأكيد الموقع';

  @override
  String get selectYourLocation => 'اختر موقعك';

  @override
  String get searchPlaceAddress => 'ابحث عن مكان أو عنوان';

  @override
  String get confirmAddress => 'تأكيد العنوان';

  @override
  String get regionName => 'اسم المنطقة';

  @override
  String get searchOrChooseRegion => 'اختر أو ابحث عن منطقتك';

  @override
  String get streetName => 'اسم الشارع';

  @override
  String get enterStreetName => 'أدخل اسم الشارع';

  @override
  String get landmark => 'علامة مميزة';

  @override
  String get landmarkExample => 'مثال: أمام بنك مصر، بجوار مدرسة...';

  @override
  String get buildingNumber => 'رقم المنزل / المبنى';

  @override
  String get buildingNumberExample => 'مثال: ١٢٣';

  @override
  String get floor => 'الدور';

  @override
  String get floorExample => 'مثال: ٣';

  @override
  String get apartmentNumber => 'رقم الشقة';

  @override
  String get apartmentExample => 'مثال: ٧';

  @override
  String get additionalNotes => 'ملاحظات إضافية';

  @override
  String get additionalNotesHint => 'اكتب أي تفاصيل تساعدنا في الوصول إليك...';

  @override
  String get setAsDefaultAddress => 'تعيين كعنوان أساسي';

  @override
  String get defaultAddressDescription => 'سيتم استخدام هذا العنوان في كل طلب.';

  @override
  String get productOptionsDescription => 'حلوى مقلية أو مخبوزة مصنوعة من عجينة حلوة، وغالباً ما تُغطى بالسكر أو الشوكولاتة.';

  @override
  String get chooseOptions => 'اختر من الخيارات:';

  @override
  String get required => 'مطلوب';

  @override
  String get chooseOne => 'اختر 1';

  @override
  String get paidAdditions => 'إضافات مدفوعة';

  @override
  String get freeAdditions => 'إضافات مجانية';

  @override
  String get optional => 'اختياري';

  @override
  String get mandatory => 'إجباري';

  @override
  String get powderedSugar => 'سكر بودرة';

  @override
  String get whiteChocolate => 'شوكولاتة بيضاء';

  @override
  String get pistachio => 'فستق مجروش';

  @override
  String get chooseQuantityToAdd => 'اختر الكمية المطلوبة لإضافة المنتج';

  @override
  String get addToOrder => 'إضافة للطلب';

  @override
  String get cartView => 'عرض السلة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get updates => 'التحديثات';

  @override
  String get offers => 'العروض';

  @override
  String get notificationOrders => 'الطلبات';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get orderConfirmedNotification => 'تم تأكيد طلبك';

  @override
  String orderConfirmedMessage(String orderNumber) {
    return 'تم تأكيد طلبك رقم #$orderNumber وجاري تحضيره.';
  }

  @override
  String get orderOnTheWayNotification => 'طلبك في الطريق';

  @override
  String orderOnTheWayMessage(String orderNumber, int minutes) {
    return 'طلبك رقم #$orderNumber في الطريق إليك وسيصلك خلال $minutes دقيقة.';
  }

  @override
  String get specialOfferNotification => 'عرض خاص 🎉';

  @override
  String specialOfferMessage(int discount) {
    return 'خصم $discount% على جميع الطلبات من اليوم وحتى نهاية الأسبوع!';
  }

  @override
  String get orderDeliveredNotification => 'تم تسليم طلبك';

  @override
  String orderDeliveredMessage(String orderNumber) {
    return 'تم تسليم طلبك رقم #$orderNumber بنجاح.';
  }

  @override
  String get appUpdateNotification => 'تحديث التطبيق';

  @override
  String get appUpdateMessage => 'تم تحديث التطبيق إلى أحدث إصدار لتحسين تجربتك.';

  @override
  String get welcomeNotification => 'أهلاً بك في تطبيقنا! 👋';

  @override
  String get welcomeMessage => 'ابدأ التسوق الآن واكتشف أفضل العروض.';

  @override
  String get noNotificationsTitle => 'لا يوجد إشعارات';

  @override
  String get noNotificationsMessage => 'ستظهر هنا إشعاراتك الجديدة عند وصولها.';

  @override
  String get pound => 'ج.م';

  @override
  String get canceled => 'ملغي';

  @override
  String timeAgo(String time) {
    return 'منذ $time';
  }

  @override
  String get minute => 'دقيقة';

  @override
  String get twoMinutes => 'دقيقتين';

  @override
  String get minutes => 'دقائق';

  @override
  String get hour => 'ساعة';

  @override
  String get twoHours => 'ساعتين';

  @override
  String get hours => 'ساعات';

  @override
  String get now => 'الآن';

  @override
  String get myAccount => 'حسابي';

  @override
  String get version => 'الإصدار';

  @override
  String get region => 'المنطقة';

  @override
  String get street => 'الشارع';

  @override
  String get details => 'تفاصيل';

  @override
  String get apartment => 'الشقة';

  @override
  String get orderNotes => 'ملاحظات الطلب';

  @override
  String get orderNotesHint => 'اكتب ملاحظاتك هنا...';

  @override
  String get orderNotesDescription => 'يمكنك كتابة أي تعليمات خاصة بطلبك (مثل: بدون سكر، كمية صوص إضافية...)';

  @override
  String get product => 'منتج';

  @override
  String get egypt => 'مصر';

  @override
  String get saudiArabia => 'السعودية';

  @override
  String get emirates => 'الإمارات';

  @override
  String get kuwait => 'الكويت';

  @override
  String get register => 'إنشاء الحساب';

  @override
  String get otpErrorSnackbarMessage => 'فشل التحقق، يُرجى التأكد من الرمز والمحاولة مرة أخرى';

  @override
  String get selectedLocation => 'الموقع المحدد';

  @override
  String get detailedAddress => 'العنوان بالتفصيل';

  @override
  String get regionIsRequired => 'يُرجى اختيار المنطقة';

  @override
  String get detailedAddressRequired => 'يرجى كتابة العنوان بالتفصيل';

  @override
  String get couponsSubtitle => 'استخدم الكوبونات واستمتع بأفضل العروض';

  @override
  String get couponsTab => 'كوبونات';

  @override
  String get offersTab => 'عروض';

  @override
  String get enterCouponCode => 'لديك كود كوبون؟ أدخله هنا';

  @override
  String get apply => 'تطبيق';

  @override
  String get availableCoupons => 'الكوبونات المتاحة';

  @override
  String get expiredCoupons => 'كوبونات منتهية';

  @override
  String get couponActive => 'نشط';

  @override
  String get couponExpired => 'منتهية';

  @override
  String get remainingUses => 'الاستخدامات المتبقية';

  @override
  String couponUsesCount(int remaining, int total) {
    return '$remaining من $total';
  }

  @override
  String get unlimited => 'غير محدود';

  @override
  String couponMinimumOrder(int amount) {
    return 'الحد الأدنى للطلب $amount جنيه';
  }

  @override
  String couponExpiresOn(String date) {
    return 'ينتهي في $date';
  }

  @override
  String couponExpiredOn(String date) {
    return 'انتهت في $date';
  }

  @override
  String get copyCode => 'نسخ الكود';

  @override
  String get codeCopied => 'تم نسخ الكود';

  @override
  String get freeShipping => 'شحن مجاني';

  @override
  String get couponsInfoTitle => 'تطبيق الكوبونات قبل الدفع';

  @override
  String get couponsInfoMessage => 'لا يمكن دمج أكثر من كوبون في الطلب الواحد';

  @override
  String get noCouponsTitle => 'لا توجد كوبونات حالياً';

  @override
  String get noCouponsMessage => 'ستظهر كوبوناتك هنا فور حصولك عليها';

  @override
  String get couponEmptyCartMessage => 'أضف منتجات إلى السلة أولاً لتطبيق الكوبون';

  @override
  String couponAppliedMessage(double discount) {
    final intl.NumberFormat discountNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String discountString = discountNumberFormat.format(discount);

    return 'تم تطبيق الكوبون! وفرت $discountString جنيه';
  }

  @override
  String offerValidUntil(String date) {
    return 'ساري حتى $date';
  }

  @override
  String get orderNow => 'اطلب الآن';

  @override
  String get noOffersTitle => 'لا توجد عروض حالياً';

  @override
  String get noOffersMessage => 'تابعنا باستمرار، ستظهر هنا العروض الجديدة فور توفرها.';

  @override
  String get restaurants => 'المطاعم';

  @override
  String get foods => 'الأطعمة';

  @override
  String get favoriteRestaurantsSubtitle => 'المطاعم التي أضفتها إلى المفضلة';

  @override
  String get addNewRestaurant => 'إضافة مطعم جديد';

  @override
  String deliveryStartsFrom(int amount) {
    return 'التوصيل يبدأ من $amount جنيه';
  }

  @override
  String get delete => 'حذف';

  @override
  String get noFavoritesTitle => 'لا توجد عناصر مفضلة بعد';

  @override
  String get noFavoritesMessage => 'يمكنك إضافة الأطعمة المفضلة لديك للوصول إليها بسرعة';

  @override
  String get account => 'الحساب';

  @override
  String get application => 'التطبيق';

  @override
  String get supportAndHelp => 'الدعم والمساعدة';

  @override
  String get accountInformation => 'معلومات الحساب';

  @override
  String get accountInformationSubtitle => 'الاسم، رقم الهاتف، البريد الإلكتروني';

  @override
  String get notificationsSubtitle => 'إدارة تفضيلات الإشعارات';

  @override
  String get enableNotifications => 'تفعيل الإشعارات';

  @override
  String get enableNotificationsSubtitle => 'استقبل تحديثات عن طلباتك والعروض';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get locationSettings => 'الموقع';

  @override
  String get locationSettingsSubtitle => 'إدارة الوصول للموقع';

  @override
  String get appearance => 'المظهر';

  @override
  String get appearanceSubtitle => 'تغيير سمة التطبيق';

  @override
  String get lightAppearance => 'المظهر الفاتح';

  @override
  String get darkAppearance => 'المظهر الداكن';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get helpCenterSubtitle => 'الأسئلة الشائعة والدعم';

  @override
  String get termsAndConditionsSubtitle => 'سياسة الاستخدام وشروط الخدمة';

  @override
  String get aboutApp => 'نبذة عن التطبيق';

  @override
  String get savedAddresses => 'العناوين المحفوظة';

  @override
  String get defaultLabel => 'الافتراضي';

  @override
  String get setAsDefault => 'تعيين كافتراضي';

  @override
  String get addressesSecured => 'جميع العناوين آمنة ومشفرة';

  @override
  String get savedPaymentMethods => 'طرق الدفع المحفوظة';

  @override
  String get addNewPaymentMethod => 'إضافة طريقة دفع جديدة';

  @override
  String get paymentMethodsSecured => 'جميع معلومات الدفع آمنة ومشفرة';

  @override
  String lastUpdated(String date) {
    return 'آخر تحديث: $date';
  }

  @override
  String get termsIntro => 'مرحباً بك في تطبيقنا. باستخدامك للتطبيق، فإنك توافق على الالتزام بهذه الشروط والأحكام. يرجى قراءتها بعناية قبل استخدام الخدمة.';

  @override
  String get termsAcceptanceTitle => 'قبول الشروط';

  @override
  String get termsAcceptanceBody => 'باستخدامك لهذا التطبيق، فإنك توافق على هذه الشروط والأحكام وجميع السياسات والإرشادات المعمول بها. إذا كنت لا توافق على أي جزء من هذه الشروط، يُرجى عدم استخدام التطبيق.';

  @override
  String get termsServiceUsageTitle => 'استخدام الخدمة';

  @override
  String get termsServiceUsageBody => 'يجب عليك استخدام التطبيق للأغراض القانونية فقط وبما يتوافق مع هذه الشروط والأحكام. أنت توافق على عدم استخدام التطبيق بأي طريقة قد تؤثر على أدائه أو تتسبب في ضرر للتطبيق أو للمستخدمين الآخرين.';

  @override
  String get termsUserAccountTitle => 'حساب المستخدم';

  @override
  String get termsUserAccountBody => 'قد تحتاج إلى إنشاء حساب لاستخدام بعض ميزات التطبيق. أنت مسؤول عن الحفاظ على سرية معلومات حسابك وعن جميع الأنشطة التي تتم باستخدام حسابك.';

  @override
  String get termsOrdersAndPaymentTitle => 'الطلبات والدفع';

  @override
  String get termsOrdersAndPaymentBody => 'جميع الطلبات تخضع للتوفر والأسعار قابلة للتغيير دون إشعار مسبق. يجب دفع جميع المبالغ المستحقة قبل تأكيد الطلب.';

  @override
  String get termsCancellationTitle => 'إلغاء الطلب واسترداد الأموال';

  @override
  String get termsCancellationBody => 'يمكنك إلغاء الطلب قبل بدء التجهيز. بعد بدء التجهيز، لا يمكن إلغاء الطلب أو استرداد المبلغ المدفوع إلا وفقاً لسياسة الاسترداد الخاصة بنا.';

  @override
  String get termsChangesTitle => 'التعديلات على الشروط';

  @override
  String get termsChangesBody => 'نحتفظ بالحق في تعديل هذه الشروط والأحكام في أي وقت. سيتم إشعارك بأي تغييرات من خلال التطبيق. استمرارك في استخدام التطبيق بعد التعديل يعني موافقتك على الشروط الجديدة.';

  @override
  String get termsContactTitle => 'التواصل معنا';

  @override
  String get termsContactBody => 'إذا كان لديك أي أسئلة أو استفسارات حول هذه الشروط والأحكام، يمكنك التواصل معنا من خلال صفحة الدعم في التطبيق.';

  @override
  String get agreeToTermsPrefix => 'لقد قرأت وأوافق على';

  @override
  String get agree => 'موافق';

  @override
  String get privacyHeroTitle => 'خصوصيتك تهمنا';

  @override
  String get privacyHeroMessage => 'نحن نلتزم بحماية بياناتك الشخصية واستخدامها بشكل آمن ومسؤول';

  @override
  String get privacyIntro => 'توضح هذه السياسة كيف نقوم بجمع واستخدام وحماية بياناتك الشخصية عند استخدامك لتطبيقنا وخدماتنا.';

  @override
  String get privacyCollectedDataTitle => 'المعلومات التي نجمعها';

  @override
  String get privacyCollectedDataBody => 'نقوم بجمع المعلومات التي تقدمها لنا مباشرة مثل الاسم، رقم الهاتف، العنوان، بالإضافة إلى معلومات الطلبات والدفع عند استخدام التطبيق.';

  @override
  String get privacyDataUsageTitle => 'كيف نستخدم معلوماتك';

  @override
  String get privacyDataUsageBody => 'نستخدم معلوماتك لتقديم وتحسين خدماتنا، معالجة الطلبات والدفع، التواصل معك، وتقديم الدعم الفني والاقتراحات المناسبة لك.';

  @override
  String get privacyDataSharingTitle => 'مشاركة المعلومات';

  @override
  String get privacyDataSharingBody => 'لا نقوم ببيع أو تأجير بياناتك الشخصية لأي جهة خارجية. قد نشارك بياناتك مع مزودي الخدمة فقط لتنفيذ الطلبات والدفع.';

  @override
  String get privacyDataProtectionTitle => 'حماية البيانات';

  @override
  String get privacyDataProtectionBody => 'نطبق معايير أمنية صارمة لحماية بياناتك من الوصول غير المصرح به أو التعديل أو الإفشاء أو التدمير.';

  @override
  String get privacyYourRightsTitle => 'حقوقك';

  @override
  String get privacyYourRightsBody => 'لديك الحق في الوصول إلى بياناتك الشخصية أو تعديلها أو حذفها في أي وقت من خلال إعدادات الحساب أو عبر التواصل معنا.';

  @override
  String get privacyChangesTitle => 'التعديلات على السياسة';

  @override
  String get privacyChangesBody => 'قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. سيتم إشعارك بأي تغييرات مهمة من خلال التطبيق.';

  @override
  String get supportHeroTitle => 'كيف يمكننا مساعدتك؟';

  @override
  String get supportHeroMessage => 'اختر الموضوع الذي تحتاج المساعدة فيه';

  @override
  String get orderIssue => 'مشكلة في الطلب';

  @override
  String get followOrder => 'متابعة الطلب';

  @override
  String get lateOrder => 'الطلب متأخر';

  @override
  String get wrongOrMissingItem => 'منتج ناقص أو خاطئ';

  @override
  String get paymentIssue => 'مشكلة في الدفع';

  @override
  String get paymentNotConfirmed => 'الدفع لم يتم تأكيده';

  @override
  String get refund => 'استرداد المبلغ';

  @override
  String get editAccountData => 'تعديل بيانات الحساب';

  @override
  String get loginIssue => 'مشكلة في تسجيل الدخول';

  @override
  String get contactUs => 'تواصل معنا';

  @override
  String get contactUsMessage => 'لم تجد ما تبحث عنه؟ نحن هنا لمساعدتك';

  @override
  String get chatWithSupport => 'تحدث مع الدعم';

  @override
  String get supportHours => 'متاح يومياً من 10 صباحاً حتى 12 منتصف الليل';

  @override
  String get processingYourOrder => 'جاري معالجة طلبك';

  @override
  String get enterInstaPayUsername => 'أدخل يوزر انستاباي الخاص بك بدون @instapay';

  @override
  String get requiredField => 'الحقل مطلوب';

  @override
  String get invalidUserName => 'اسم المستخدم غير صالح';

  @override
  String get confirmPayment => 'تأكيد الدفع';

  @override
  String get yourCurrentBalance => 'رصيدك الحالي';

  @override
  String get enterWalletNumber => 'أدخل رقم المحفظة التي سترسل منها';

  @override
  String get sendMoneyToNumber => 'أرسل الحساب إلى هذا الرقم';

  @override
  String get vodafoneCash => 'ڤودافون كاش';

  @override
  String get unknownError => 'خطأ غير متوقع';

  @override
  String get notificationSettings => 'إعدادات الإشعارات';

  @override
  String get emptyCartTitle => 'السلة فارغة';

  @override
  String get emptyCartMessage => 'أضف منتجات من القائمة لتظهر هنا';

  @override
  String get sizeIsRequired => 'يُرجى اختيار الحجم';

  @override
  String get orderPlacedMessage => 'تم إرسال طلبك بنجاح';

  @override
  String chooseUpTo(int count) {
    return 'اختر حتى $count';
  }

  @override
  String get cannotBeCombined => 'يُختار بمفرده، ولا يمكن جمعه مع اختيارات أخرى';

  @override
  String minSelectionRequired(int count, String group) {
    return 'يُرجى اختيار $count على الأقل من $group';
  }
}
