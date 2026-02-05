# test_task
# Dependencies Used & Why
  flutter_bloc: ^9.1.1 #for state management
  equatable: ^2.0.8 #for comparing two object by value.
  get_it: ^9.2.0 #for dependency management
  go_router: ^17.1.0 #for routing purpose
  flutter_screenutil: ^5.9.3 # A flutter plugin for adapting screen and font size
  google_fonts: ^8.0.1 #A Flutter package to use fonts from fonts.google.com.
  intl: ^0.20.2 # for date formatting in the week strip on the Home screen
  easy_localization: ^3.0.8 #  Easy translations for many languages
  flutter_svg: ^2.2.3 # for vector icons in app
# Project Structure
The project follows Clean Architecture principles to ensure scalability, testability, and maintainability.
Each feature is isolated, and responsibilities are clearly separated.
lib/
 ├── core/
 ├── features/
 ├── app.dart
 └── main.dart
 # core/
 Contains shared and reusable code used across the entire application.
core/
 ├── assets/        → Asset path constants (SVGs, images, icons)
 ├── di/            → Dependency injection setup (GetIt)
 ├── theme/         → App colors, typography, and themes
 ├── localization/  → Easy Localization setup & translation keys
 ├── router/        → GoRouter configuration and routes
 ├── utils/         → Helpers, extensions, constants
 └── widgets/       → Reusable UI widgets (buttons, cards, headers)

features/
Each feature module contains everything related to that specific functionality.
Example:
features/
 └── mood/
     ├── data/
     ├── domain/
     └── presentation/

data/
Handles data sources and models.
data/
 ├── models/        → Data models (DTOs)
 ├── repositories/  → Repository implementations
 └── sources/       → Local / Remote data sources

domain/
Contains business logic and is independent of Flutter.
domain/
 ├── entities/      → Core business objects
 ├── repositories/  → Abstract repository contracts
 └── usecases/      → Application-specific business rules

presentation/
UI layer of the feature.
presentation/
 ├── cubit/         → State management (BLoC/Cubit)
 ├── pages/         → Screens / Views
 └── widgets/       → Feature-specific widgets
 # images:
 
 ![WhatsApp Image 2026-02-05 at 4 47 17 PM](https://github.com/user-attachments/assets/7b19321f-0fb1-4191-82c9-6e4ad4dabf6a)

![WhatsApp Image 2026-02-05 at 4 47 18 PM](https://github.com/user-attachments/assets/67d2d1da-6ec5-4f43-8f4b-75b309ff8ab4)

# Video link
https://drive.google.com/file/d/1E9dWh-L4EkIF9YWCe7h7hNzE1oZZgPIT/view?usp=sharing
# Apk link
https://drive.google.com/file/d/1qZG-VUYIc85jNTIgiqaa627I_cFlPjHT/view?usp=sharing

A flutter test task

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
