// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'كليك فلو';

  @override
  String get welcomeMessage => 'مرحباً بك في كليك فلو';

  @override
  String get locationPickerTitle => 'اختر موقع العيادة';

  @override
  String get locationPickerMyLocation => 'موقعي';

  @override
  String get locationPickerLoadingMap => 'جارٍ تحميل الخريطة…';

  @override
  String locationPickerTapHint(String lat, String lng) {
    return 'اضغط على الخريطة لتحريك الدبوس • خط العرض $lat، خط الطول $lng';
  }

  @override
  String get locationPickerConfirm => 'تأكيد الموقع';

  @override
  String get commonTryAgain => 'حاول مجدداً';
}
