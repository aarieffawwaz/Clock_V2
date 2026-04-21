# Copilot Instructions for Clock_V2

## Build & Test Commands

### Building
```bash
# Build the app for Debug
xcodebuild -project Clock_V2.xcodeproj -scheme Clock_V2 -configuration Debug build

# Build for Release
xcodebuild -project Clock_V2.xcodeproj -scheme Clock_V2 -configuration Release build
```

### Testing

#### Unit Tests (Swift Testing framework)
```bash
# Run all unit tests
xcodebuild -project Clock_V2.xcodeproj -scheme Clock_V2 -configuration Debug test -only-testing Clock_V2Tests

# Run a single test
xcodebuild -project Clock_V2.xcodeproj -scheme Clock_V2 -configuration Debug test -only-testing Clock_V2Tests/Clock_V2Tests/example
```

#### UI Tests (XCUITest framework)
```bash
# Run all UI tests
xcodebuild -project Clock_V2.xcodeproj -scheme Clock_V2 -configuration Debug test -only-testing Clock_V2UITests

# Run a specific UI test
xcodebuild -project Clock_V2.xcodeproj -scheme Clock_V2 -configuration Debug test -only-testing Clock_V2UITests/Clock_V2UITests/testExample
```

### Using Xcode GUI
For interactive development, open the project in Xcode:
```bash
open Clock_V2.xcodeproj
```

## Architecture Overview

### App Structure
Clock_V2 is a SwiftUI app using **SwiftData** for persistence. The core components are:

- **Clock_V2App** (`Clock_V2App.swift`): App entry point that sets up the SwiftData model container with the `Item` model. Manages the shared `ModelContainer` instance.
- **ContentView** (`ContentView.swift`): Main UI using `NavigationSplitView` with a sidebar list showing all items and a detail panel. Supports adding items via the plus button and deletion via swipe.
- **Item** (`Item.swift`): SwiftData `@Model` representing a timestamped entry. Currently stores only a timestamp.

### Data Persistence
- Uses **SwiftData** (`import SwiftData`) for ORM and persistence
- Data is stored locally on disk (not in-memory)
- The model container is initialized in `Clock_V2App` and injected via `.modelContainer(sharedModelContainer)` modifier
- Access data in views via `@Environment(\.modelContext)` and `@Query` property wrapper

### Testing Strategy
- **Unit Tests**: Use Swift Testing framework (not XCTest). Located in `Clock_V2Tests/`
- **UI Tests**: Use XCUITest framework. Located in `Clock_V2UITests/`
- Both test targets link to the main app target via build dependencies

## Key Conventions

### SwiftUI Patterns
- Views use property wrappers for data access:
  - `@Environment(\.modelContext)` for accessing SwiftData model context
  - `@Query` for querying SwiftData models
- Use `withAnimation { }` when performing model changes to synchronize animations
- Preview macros (`#Preview`) are included in views for live canvas development

### SwiftData Model Pattern
- Models use `@Model` macro instead of manual conformance
- Models are `final class` (not structs)
- Models must have designated `init` with all properties

### File Organization
- One model per file (e.g., `Item.swift`)
- Views grouped by functionality (e.g., `ContentView.swift`)
- App setup in `Clock_V2App.swift`

### Testing Conventions
- Swift Testing: Use `@Test` macro and `#expect(...)` assertions
- XCUITest: Use `XCUIApplication()` to launch the app, standard `XCTAssert*` assertions
- Placeholder tests are present by default; replace with actual test implementations

## Common Tasks

### Adding a New SwiftData Model
1. Create a new `.swift` file in the `Clock_V2/` directory
2. Use the `@Model final class` pattern
3. Update `Clock_V2App` to include the model in `Schema([...])`

### Modifying the UI
- All UI is in `ContentView.swift`
- Use SwiftUI modifiers and `.toolbar`, `.onDelete`, etc.
- Test changes using `#Preview` in the editor

### Querying Data
- In views, use `@Query private var items: [Item]` to fetch all items of a type
- Use the `@Environment(\.modelContext)` to insert/delete models with `.insert()` and `.delete()`

## Testing Notes
- Swift Testing documentation: https://developer.apple.com/documentation/testing
- XCUIAutomation documentation: https://developer.apple.com/documentation/xcuiautomation
- Placeholder tests exist in both test targets; implement actual tests as needed
