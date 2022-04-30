import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/authentication_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_my_profile_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/theme_mode_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
    (ref) => ThemeModeNotifier());

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
        (ref) => AuthenticationNotifier());

final getMyProfileProvider =
    StateNotifierProvider<GetMyProfileNotifier, GetMyProfileState>(
        (ref) => GetMyProfileNotifier());
