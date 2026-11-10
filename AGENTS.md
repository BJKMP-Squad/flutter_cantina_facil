# AGENTS.md

Flutter app scaffold (default counter template). Entrypoint: `lib/main.dart` (`MyApp`).

## Commands

- `flutter pub get` — install deps (only `flutter`, `cupertino_icons`, `flutter_lints`).
- `flutter analyze` — static analysis (uses `flutter_lints` via `analysis_options.yaml`).
- `flutter test` — all tests; single test: `flutter test test/widget_test.dart`.
- `flutter run -d chrome` — web target; `flutter run -d <android-device>` for Android.

## Repo facts

- Only `android/` and `web/` platforms are scaffolded (see `.metadata`). No `ios/`, `macos/`, `linux/`, or `windows/` dirs; run `flutter create . --platforms=<name>` before targeting them.
- Analyzer ignores `build/**`, `android/**`, `web/**`; lint/format changes should target `lib/` and `test/`.
- Code uses Dart dot-shorthand syntax (e.g. `.fromSeed(...)`, `mainAxisAlignment: .center`), which requires the SDK constraint `^3.13.3` in `pubspec.yaml`. Do not downgrade the SDK or "fix" this syntax to older forms.
- `test/widget_test.dart` imports `package:flutter_cantina_facil/main.dart`; keep `MyApp` exported from `lib/main.dart` or update that test.
- `mer.md` is an empty untracked scratch file; leave it out of commits unless asked.
