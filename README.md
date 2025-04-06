# LumiformChallenge

A SwiftUI app that displays hierarchical content fetched from a remote API, featuring a clean architecture, responsive UI, and comprehensive test coverage.

## Features

- Content browser with hierarchical display of pages, sections, text, and images
- Full-screen image view with pinch-to-zoom functionality
- Offline support with Realm database caching
- Responsive design that adapts to different device sizes
- Comprehensive test coverage with unit and UI tests

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Models**: Data structures that represent the app's content
- **Views**: SwiftUI views that display the content
- **ViewModels**: Classes that handle business logic and provide data for views
- **Services**: Classes that handle data fetching and processing

## Project Structure

- **App**: Entry point of the application
- **Models**: Data models and structures
- **Views**: SwiftUI views organized by screens and components
- **ViewModels**: View models for handling business logic
- **Services**: Network and data services
- **Utilities**: Helper classes and extensions
- **Resources**: Assets and resources

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Dependencies

The project uses the following third-party libraries:

- **RealmSwift**: For local data persistence
- **SDWebImageSwiftUI**: For efficient image loading and caching

## Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/kirlosyousef/LumiformChallenge.git
   cd LumiformChallenge
   ```

2. **Install dependencies**

   The project uses Swift Package Manager for dependencies. Xcode should automatically resolve these when you open the project.

   If needed, you can manually update dependencies:
   - Open the project in Xcode
   - Go to File > Packages > Resolve Package Versions

3. **Build and run**

   - Open `LumiformChallenge.xcodeproj` in Xcode
   - Select your target device or simulator
   - Press Cmd+R to build and run the app

## Environment Configuration

The app supports different environments (development, staging, production) that can be configured in the `AppEnvironment.swift` file:

```swift
// Switch between environments by changing this value
static var current: ConfigType {
    #if DEBUG
    return .development
    #else
    return .production
    #endif
}
```

## Testing

The project includes both unit tests and UI tests:

- **Unit Tests**: Tests for models, view models, and services
- **UI Tests**: Tests for user interface interactions

For detailed information about tests, see:
- [Unit Tests Documentation](LumiformChallengeTests/README.md)
- [UI Tests Documentation](LumiformChallengeUITests/README.md)

To run the tests:
- Open the project in Xcode
- Press Cmd+U to run all tests
- Or select specific test targets from the Test Navigator
