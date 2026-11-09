# Flutter Uniqlo 🛍️

A Flutter-based e-commerce mobile application inspired by UNIQLO, built with Dart and Flutter. The application demonstrates mobile authentication, product browsing, shopping cart management and state management using Provider.

## Overview

Flutter Uniqlo is a mobile shopping application developed to explore Flutter application development, REST API integration and state management.

The project focuses on building a structured mobile application with reusable components, separated application logic and a responsive user interface.

## Features

### Authentication
- User login and registration interfaces.
- Password recovery screen.
- REST API integration for user authentication.
- Access and refresh token management.
- Persistent authentication sessions using SharedPreferences.
- Automatic login and session restoration.

### Product Browsing
- Product listing interface.
- Product cards displaying product information.
- Product descriptions and pricing.

### Shopping Cart
- Add products to the shopping cart.
- Increase and decrease product quantities.
- Remove products from the cart.
- Automatically calculate cart totals.
- Display the current cart total.

### Navigation
- Home screen.
- Shopping cart.
- Orders section.
- User profile.
- Bottom navigation for switching between application sections.

## Technologies Used

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile development |
| Dart | Application programming language |
| Provider | Application state management |
| ChangeNotifier | Reactive state updates |
| HTTP | REST API communication |
| SharedPreferences | Local token storage |
| DummyJSON API | Authentication API |
| Material Design | Mobile UI components |

## Application Architecture

The application separates authentication, state management, models and user interface components.

Key components include:

- **Models:** Represent application data, including users, products and cart items.
- **Services:** Handle authentication requests and communication with external APIs.
- **ViewModels:** Manage authentication state, API responses and application logic.
- **Providers:** Manage shared application state, including authentication and shopping cart operations.
- **Screens:** Present the application's user interfaces and navigation.

## Project Structure

```text
lib/
├── model/
│   ├── cart.dart
│   ├── cart_item.dart
│   ├── cart_card.dart
│   ├── product.dart
│   ├── product_card.dart
│   ├── user.dart
│   └── token_response.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── forgotpass_screen.dart
│   └── redirect.dart
│
├── service/
│   └── auth_api.dart
│
├── viewmodel/
│   └── view_model.dart
│
└── main.dart
```

## Getting Started

### Prerequisites

Before running the project, ensure you have:

- Flutter SDK installed.
- Dart SDK.
- Android Studio or Visual Studio Code.
- An Android emulator, iOS simulator or physical device.
- Git installed.

### Installation

1. Clone the repository:

```bash
git clone https://github.com/jmainamercy/flutter-uniqlo.git
```

2. Navigate into the project:

```bash
cd flutter-uniqlo
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

## API Integration

The application uses the DummyJSON authentication API for user authentication.

API base URL:

```text
https://dummyjson.com
```

Authentication endpoints:

- `POST /auth/login` – Authenticate users.
- `GET /auth/me` – Retrieve authenticated user information.
- `POST /auth/refresh` – Refresh authentication tokens.

Product information currently uses sample data defined within the application.

## Testing

Run the Flutter test suite using:

```bash
flutter test
```

Run static analysis using:

```bash
flutter analyze
```

## Future Improvements

Potential improvements include:

- Integration with a live product catalogue API.
- Product search and category filtering.
- Product detail screens.
- Persistent shopping cart storage.
- Complete order management and checkout workflows.
- Improved authentication and error handling.
- Automated widget and integration testing.

## Author

**Mercy Maina**

Software Developer | Flutter & Mobile Engineering

- GitHub: [@jmainamercy](https://github.com/jmainamercy)
- Email: jmainamercy@gmail.com

---

This project was developed as part of my exploration of Flutter mobile application development, application architecture and API integration.
