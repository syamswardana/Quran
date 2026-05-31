# Simple Quran

A simple and beautiful Flutter Quran application implementing Clean Architecture.

## 🏗️ Project Structure

This project follows Clean Architecture principles to separate concerns and maintain a scalable codebase. The main code is located in the `lib` directory:

```text
lib/
├── core/           # Core utilities, extensions, network, and audio services
├── data/           # Data layer containing repositories implementations, models, and data sources (API)
├── domain/         # Domain layer containing entities, abstract repositories, and use cases
└── presentation/   # Presentation layer containing UI (pages/widgets) and state management (BLoC)
```

## 📦 Requirements

- **Flutter SDK**: ^3.12.0
- **flutter_bloc**: ^9.1.0 (Minimum required version)

## 🚀 How to Run

Follow these steps to run the application on your local machine:

1. **Get Dependencies**:
   Run the following command to install all required packages:
   ```bash
   flutter pub get
   ```

2. **Generate Files**:
   Since this project uses `get_it` and `mockito` (for tests), it might require code generation. Run:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run the App**:
   Ensure you have a device connected or an emulator running, then execute:
   ```bash
   flutter run
   ```

## 🧪 Running Tests

To run the unit and widget tests:

```bash
flutter test
```
