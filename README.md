# BizWiz

A Flutter web application featuring an interactive card-based interface.

## Features

- Responsive grid layout with cards
- Interactive cards with images and text
- Detailed view dialog for each card
- Smooth scrolling interface
- Material Design 3 styling

## Getting Started

This project is built with Flutter and runs in the browser.

### Prerequisites

- Flutter SDK
- Chrome or another modern web browser

### Running the app

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run -d chrome` to start the app in Chrome

## Development

- The main application code is in `lib/main.dart`
- The app uses Material Design 3
- Web-specific configurations are in the `web` directory

### Project Structure

- Cards are arranged in a responsive grid layout
- Each card contains:
  - An image (loaded from picsum.photos)
  - A title
  - A brief description
  - A "Tap to view more" indicator
- Clicking a card opens a detailed dialog with:
  - A larger version of the image
  - More detailed information
  - Scrollable content
  - A close button

### Dependencies

The app uses the following Flutter packages:
- `material.dart` for UI components
- Network image loading for card images
