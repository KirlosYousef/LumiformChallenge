# LumiformChallenge Unit Tests

This folder contains the unit tests for the LumiformChallenge app, designed to verify the functionality of individual components in isolation.

## Structure

The unit tests are organized according to the following structure:

- **ModelsTests**: Tests for data model functionality
- **ViewModelsTests**: Tests for view model business logic
- **NetworkingTests**: Tests for networking and API interactions
- **Mocks**: Mock implementations for testing purposes

## Test Coverage

The unit tests cover the following areas:

- **Models**: Tests for model serialization, depth level calculations, and data transformations
- **ViewModels**: Tests for data loading, error handling, and state management
- **Networking**: Tests for API requests, response handling, and error scenarios

## Running the Tests

To run the unit tests:

1. Open the project in Xcode.
2. Select the "LumiformChallengeTests" scheme.
3. Press Cmd+U or navigate to Product > Test.
4. View the test results in the Test Navigator.

You can also run individual test classes or methods by:
- Clicking the diamond icon next to the test in the source editor
- Right-clicking a test class or method in the Test Navigator and selecting "Run"

## Mock Data

The tests use mock data to simulate API responses and avoid network dependencies. Mock data is defined in the `Mocks` directory.

Example of using mock data:

```swift
// Testing with a mock page
func testPageViewModel() {
    // Arrange
    let mockNetworkService = MockNetworkService(mockResponse: MockPage.valid)
    let viewModel = PageViewModel(networkService: mockNetworkService)
    
    // Act
    await viewModel.loadData()
    
    // Assert
    XCTAssertFalse(viewModel.page.isEmpty)
    XCTAssertNil(viewModel.errorMessage)
}
```

## Dependency Injection

The tests use dependency injection to substitute real implementations with test doubles:

```swift
// Example of dependency injection in tests
func testNetworkServiceWithError() async {
    // Arrange
    let mockClient = MockNetworkClient(shouldFail: true)
    let networkService = NetworkService(client: mockClient)
    
    // Act & Assert
    do {
        let _ = try await networkService.fetchPage()
        XCTFail("Expected error was not thrown")
    } catch {
        XCTAssertTrue(error is NetworkError)
    }
}
```

## Test Helpers

The `TestHelpers` directory contains utility functions and extensions to make tests more readable and maintainable.

## Writing New Tests

When writing new tests:

1. Follow the Arrange-Act-Assert (AAA) pattern:
   - Arrange: Set up the test data and conditions
   - Act: Perform the action being tested
   - Assert: Verify the results

2. Keep tests independent:
   - Each test should run independently of others
   - Clean up after tests in the `tearDown` method

3. Use descriptive test names:
   - Name should describe what is being tested
   - Follow the pattern `test_[MethodUnderTest]_[Scenario]_[ExpectedResult]`

Example:

```swift
func test_loadData_withValidResponse_shouldUpdatePageItems() async {
    // Arrange
    let mockService = MockNetworkService(mockResponse: MockPage.valid)
    let viewModel = PageViewModel(networkService: mockService)
    
    // Act
    await viewModel.loadData()
    
    // Assert
    XCTAssertFalse(viewModel.page.isEmpty)
    XCTAssertEqual(viewModel.page.count, 1)
}
```

## Continuous Integration

For CI/CD pipelines, you can run the tests using Xcode's command-line tools:

```bash
xcodebuild test -project LumiformChallenge.xcodeproj -scheme LumiformChallengeTests -destination 'platform=iOS Simulator,name=iPhone 15'
``` 