// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Clinic Flow';

  @override
  String get welcomeMessage => 'Welcome to Clinic Flow';

  @override
  String get locationPickerTitle => 'Pick clinic location';

  @override
  String get locationPickerMyLocation => 'My location';

  @override
  String get locationPickerLoadingMap => 'Loading map…';

  @override
  String locationPickerTapHint(String lat, String lng) {
    return 'Tap the map to move the pin • Lat $lat, Lng $lng';
  }

  @override
  String get locationPickerConfirm => 'Confirm location';

  @override
  String get commonTryAgain => 'Try again';
}
