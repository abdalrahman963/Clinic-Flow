import 'package:equatable/equatable.dart';

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

class GetSavedLanguageEvent extends LocaleEvent {}

class BindPreferencesScopeEvent extends LocaleEvent {
  const BindPreferencesScopeEvent(this.scope);

  final String scope;

  @override
  List<Object> get props => [scope];
}

class ChangeLanguageEvent extends LocaleEvent {
  const ChangeLanguageEvent({required this.languageCode});

  final String languageCode;

  @override
  List<Object> get props => [languageCode];
}
