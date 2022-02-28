# Flutter_Learn

| Platfrom      | Build Status  | 
| ------------- | ------------- |
| `Android`     | `Pass`        | 
| `IOS`         | `Pass`        |
<img width="929" alt="image" src="https://user-images.githubusercontent.com/5262381/155919707-587814d6-c63a-4092-807e-b8c6114e77d3.png">


# My Build Environment

[✓] Flutter (Channel beta, 2.11.0-0.1.pre, on macOS 12.2.1 21D62 darwin-x64, locale en-SG)
    • Flutter version 2.11.0-0.1.pre at /Users/zhulian/Flutter_SDK/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision b101bfe32f (12 days ago), 2022-02-16 07:36:54 -0800
    • Engine revision e355993572
    • Dart version 2.17.0 (build 2.17.0-69.2.beta)
    • DevTools version 2.10.0-dev.1

[!] Android toolchain - develop for Android devices (Android SDK version 32.1.0-rc1)
    • Android SDK at /Users/zhulian/Library/Android/sdk
    ✗ cmdline-tools component is missing
      Run `path/to/sdkmanager --install "cmdline-tools;latest"`
      See https://developer.android.com/studio/command-line for more details.
    ✗ Android license status unknown.
      Run `flutter doctor --android-licenses` to accept the SDK licenses.
      See https://flutter.dev/docs/get-started/install/macos#android-setup for more details.

[✓] Xcode - develop for iOS and macOS (Xcode 13.2.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • CocoaPods version 1.11.2

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2021.1)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 11.0.11+0-b60-7590822)

[✓] VS Code (version 1.64.2)
    • VS Code at /Users/zhulian/Downloads/Visual Studio Code.app/Contents
    • Flutter extension version 3.34.0

[✓] Connected device (4 available)
    • CLT L29 (mobile)        • WCR0218508005770                     • android-arm64  • Android 10 (API 29)
    • sdk gphone x86 (mobile) • emulator-5554                        • android-x86    • Android 11 (API 30) (emulator)
    • iPhone 13 (mobile)      • 9602FB50-860B-4AAB-89CB-E25AB2945761 • ios            • com.apple.CoreSimulator.SimRuntime.iOS-15-2 (simulator)
    • Chrome (web)            • chrome                               • web-javascript • Google Chrome 98.0.4758.109

[✓] HTTP Host Availability
    • All required HTTP hosts are available

# Before Build

$ flutter channel beta

$ flutter upgrade

$ flutter doctor

$ flutter clean

$ flutter pub get

$ flutter run

# If Package missing

$ flutter pub add get_it

$ flutter pub add http

$ flutter pub add flutter_web_browser

$ flutter pub add intl

# Task List

![image](https://user-images.githubusercontent.com/5262381/155918781-1484635e-ae69-4f87-8079-521ab492c38d.png)

Task 1: Done

Task 2: Done

Task 3: Done

Task 4: Done

# Todo
1, Currently saving tag only in memory instead DB or local, so if user close the app the saved bookmark will be disappear.

2, Update asset file to OnLoop provided.

3, Currently everything is hardcode in stead configurable, later need to make it configuarable.

4, Not testd on device and different models, need to make app resonsilbe for different device.

# Preblem encountered

1, UI: Layout, overflow....

2, Data: Dependency Injection for "provider" and "get_it", final decision is "get_it" cuz it's easy to use

# Conclusion:

This solution will consume server and network resource but it's fast to develop, because for saving tags and filtering content with tag, I will recall API to retrieve all data from server, and if Data ID matching I will load them and display for user. By right, for better performance and saving server resource we need only load all data for first time then reuse it by differen model, but this will spend some time for coding it, I think I will implement it in future.

Anyway, this is a very interesting task and let me learn much from it. 


