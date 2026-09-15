import 'package:clinic_flow/core/preferences/user_preference_scope.dart';
import 'package:clinic_flow/core/preferences/user_preferences_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'locale_event.dart';
import 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc({required UserPreferencesStore preferencesStore})
      : _store = preferencesStore,
        super(const LocaleState(Locale('en'))) {
    on<GetSavedLanguageEvent>(_onGetSaved);
    on<BindPreferencesScopeEvent>(_onBindScope);
    on<ChangeLanguageEvent>(_onChange);
  }

  final UserPreferencesStore _store;
  String _scope = UserPreferenceScope.guest;

  Future<void> _onGetSaved(GetSavedLanguageEvent event, Emitter<LocaleState> emit) async {
    final code = await _store.getLocale(_scope);
    emit(LocaleState(Locale(code)));
  }

  Future<void> _onBindScope(BindPreferencesScopeEvent event, Emitter<LocaleState> emit) async {
    _scope = event.scope;
    final code = await _store.getLocale(_scope);
    emit(LocaleState(Locale(code)));
  }

  Future<void> _onChange(ChangeLanguageEvent event, Emitter<LocaleState> emit) async {
    await _store.setLocale(_scope, event.languageCode);
    emit(LocaleState(Locale(event.languageCode)));
  }
}
