#!/usr/bin/env bash
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
#flutter pub run bin/localization_generator/localization_generator.dart
#flutter build apk -t lib/main_stage.dart --release --flavor stage
#--build-number 9
# see available emulators
#flutter emulators
# launch desired emulator
#flutter emulators --launch <emulator id>
# run app
#flutter run -d <device-id> --flavor {stage,prod}




