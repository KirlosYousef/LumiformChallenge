# LumiformChallenge UI Tests

This folder contains the UI tests for the LumiformChallenge app, designed to verify the app's UI behavior and user interactions.

## Structure

The UI tests are organized according to the following structure:

- **BaseTests**: Contains base test classes that provide common functionality for UI tests.
- **Helpers**: Contains helper classes and utilities for UI testing.
- **PageObjects**: Contains page object models representing screens and components of the app.
- **Tests**: Contains the actual test cases, organized by feature or screen.

## Page Object Model Pattern

The tests follow the Page Object Model (POM) pattern, which provides several benefits:

- **Separation of concerns**: Test logic is separated from UI interaction logic.
- **Reusability**: Page objects can be reused across multiple test cases.
- **Maintainability**: Changes to the UI only require updates to the page objects, not to the test cases.
- **Readability**: Test cases are more readable and focused on the test scenario.

## Test Coverage

The UI tests cover the following scenarios:

- **MainViewUITests**: Tests for the main view of the app, including content loading, error handling, and empty state.
- **ContentListUITests**: Tests for the content list, including content interaction and display.
- **General**: Tests for basic UI elements, accessibility, and launch performance.

## Setting Up UI Tests

### Prerequisites

- The app should be configured to recognize UI test-specific launch arguments

### App Configuration for UI Testing

For the UI tests to work properly, the app needs to handle the launch arguments defined in `AppConfiguration.swift`:

```swift
// In your app's initialization code (e.g., AppDelegate or Scene setup)
func handleLaunchArguments() {
    let arguments = ProcessInfo.processInfo.arguments
    
    if arguments.contains("-useMockData") {
        // Configure app to use mock data
    }
    
    if arguments.contains("-forceLoadingState") {
        // Configure app to show loading state
    }
    
    if arguments.contains("-forceEmptyState") {
        // Configure app to show empty state
    }
    
    if arguments.contains("-forceErrorState") {
        // Configure app to show error state
    }
}
```

## Running the Tests

To run the UI tests:

1. Open the project in Xcode.
2. Select the "LumiformChallengeUITests" scheme.
3. Choose a device or simulator to run the tests on.
4. Click the "Test" button or use the keyboard shortcut Cmd+U.

### Running Specific Tests

You can run individual test classes or methods by:

- Clicking the diamond icon next to the test in the source editor
- Right-clicking a test class or method in the Test Navigator and selecting "Run"

### Running from the Command Line

For CI/CD pipelines, you can run the UI tests using Xcode's command-line tools:

```bash
xcodebuild test -project LumiformChallenge.xcodeproj -scheme LumiformChallengeUITests -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Test Configuration

The tests are configured to use mock data by default to ensure consistent test results. The `AppConfiguration` class provides the following options:

- **useMockData**: Use mock data instead of making real network requests.
- **forceLoadingState**: Force the app to show the loading state.
- **forceEmptyState**: Force the app to show the empty state.
- **forceErrorState**: Force the app to show an error.

These configurations can be used to test different app states without relying on network conditions.

## Writing New UI Tests

When adding new UI tests:

1. **Create or update page objects**:
   
   ```swift
   class NewFeatureScreen {
       private let app: XCUIApplication
       
       var someElement: XCUIElement {
           app.buttons["someIdentifier"]
       }
       
       init(app: XCUIApplication) {
           self.app = app
       }
       
       @discardableResult
       func performSomeAction() -> Self {
           someElement.tap()
           return self
       }
   }
   ```

2. **Add the page object to BaseUITest**:

   ```swift
   class BaseUITest: XCTestCase {
       // Existing code...
       
       lazy var newFeatureScreen = NewFeatureScreen(app: app)
       
       // Existing code...
   }
   ```

3. **Write test cases using the page objects**:

   ```swift
   final class NewFeatureUITests: BaseUITest {
       func testSomeNewFeature() throws {
           launchApp()
           
           mainScreen
               .waitForScreenToLoad()
               .navigateToNewFeature()
               
           newFeatureScreen
               .performSomeAction()
               .assertExpectedResult()
               
           TestHelper.takeScreenshot(of: app, name: "NewFeature")
       }
   }
   ```

## Screenshots

The tests take screenshots at important points in the test execution to provide visual verification of the app's state. These screenshots are attached to the test results and can be viewed in the Xcode test report.

Screenshots are saved using the `TestHelper.takeScreenshot()` method:

```swift
TestHelper.takeScreenshot(of: app, name: "ScreenName", lifetime: .keepAlways)
```

## Accessibility Testing

The tests include checks for accessibility to ensure that the app is usable by people with disabilities. The tests verify that important UI elements are accessible and properly labeled.

Example of accessibility testing:

```swift
func testAccessibility() throws {
    launchApp()
    
    // Verify navigation title is accessible
    XCTAssertTrue(mainScreen.navigationTitle.isEnabled)
    
    // Test other accessibility properties
    if mainScreen.contentList.exists {
        XCTAssertTrue(mainScreen.contentList.isEnabled)
    }
}
```

## Troubleshooting

If UI tests are failing, check the following:

1. **Element identification**: Ensure UI elements have proper identifiers accessible to UI tests.
2. **Test timing**: Adjust wait timeouts in `TestHelper` if tests are timing out.
3. **Simulator state**: Use a clean simulator without previous app data.
4. **Orientation**: UI tests are configured to run in portrait mode; verify your app supports this orientation.
5. **Screenshots**: Review test failure screenshots to identify UI issues.
