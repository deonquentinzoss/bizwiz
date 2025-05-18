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
3. Choose one of the following options to run the app:
   - Run `flutter run -d web-server` to start the app using the web server (recommended)
   - Run `flutter run -d chrome` to start the app in Chrome (requires Chrome to be installed)

The app will be available at `http://localhost:<port>` where the port is automatically assigned.

## Development

- The main application code is in `lib/main.dart`
- The app uses Material Design 3
- Web-specific configurations are in the `web` directory

### Development Commands

While running the app in debug mode, you can use the following commands:
- Press "r" for hot reload
- Press "R" for hot restart
- Press "h" for help
- Press "q" to quit

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
