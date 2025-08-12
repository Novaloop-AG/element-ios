# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Element iOS is a Matrix client for iOS built with a hybrid UIKit/SwiftUI architecture. The codebase uses MVVM-Coordinator pattern for UIKit components and modern SwiftUI for newer features.

## Essential Commands

### Initial Setup
```bash
./setup_project.sh  # Complete project setup (generates xcodeproj, installs pods)
```

### Development
```bash
xcodegen            # Generate Xcode project from project.yml
pod install         # Install CocoaPods dependencies
open Riot.xcworkspace  # Open in Xcode (use workspace, not project)

# Build and test
bundle exec fastlane build
bundle exec fastlane test

# Run specific tests
xcodebuild test -workspace Riot.xcworkspace -scheme Riot -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Creating New Screens
```bash
# MVVM-C UIKit screen
./Tools/Templates/createScreen.sh ScreenFolder MyScreenName

# SwiftUI screen
./Tools/Templates/createSwiftUISimpleScreen.sh ScreenFolder MyScreenName
```

## Architecture

### Core Structure
- **Riot/Modules/** - Feature modules following MVVM-Coordinator pattern
  - Each module has: Coordinator, ViewModel, ViewController, Views
  - Navigation handled by coordinators
- **RiotSwiftUI/** - SwiftUI components and screens
- **MatrixKit/** - Legacy Objective-C Matrix SDK integration layer
- **DesignKit/** - Design system (colors, fonts, components)

### Key Architectural Patterns
1. **MVVM-Coordinator**: Primary pattern for UIKit features
   - Coordinator handles navigation flow
   - ViewModel contains business logic
   - ViewController manages UI
2. **SwiftUI Integration**: New features use SwiftUI with ViewModels
3. **Dependency Injection**: Services passed through coordinators

### Module Communication
- Coordinators communicate via delegation patterns
- ViewModels use Combine/closures for reactive updates
- Matrix SDK events handled through NotificationCenter

## Testing Approach

Tests are located in:
- `/RiotTests/` - Unit tests for main app
- `/RiotSwiftUI/RiotSwiftUITests/` - SwiftUI component tests

Run tests with:
```bash
bundle exec fastlane test
# Or in Xcode: Cmd+U
```

## Matrix SDK Integration

The app uses matrix-ios-sdk as a git submodule at `/matrix-ios-sdk/`. Key integration points:
- **MXSession**: Core Matrix session management
- **MXRoom**: Room operations and state
- **MXCrypto**: End-to-end encryption
- **MatrixKit**: UI helpers and legacy components

## Important Configuration

### Build Configuration
- **project.yml**: XcodeGen configuration (source of truth for project structure)
- **Config/*.xcconfig**: Build settings per environment
- **Podfile**: CocoaPods dependencies

### Code Quality
- SwiftLint enforced (`.swiftlint.yml`)
- SwiftFormat for consistent formatting
- All new code should follow existing patterns in the module

## Common Development Tasks

### Adding a New Feature Module
1. Create module structure in `/Riot/Modules/YourFeature/`
2. Follow existing MVVM-C pattern from other modules
3. Register coordinator in appropriate parent coordinator
4. Add to project.yml if creating new group

### Modifying Matrix SDK Behavior
1. Check if change belongs in MatrixKit wrapper layer
2. For SDK changes, modify in `/matrix-ios-sdk/` submodule
3. Test encryption features carefully - they're critical

### Working with Localization
- Strings in `Riot/Assets/en.lproj/Vector.strings`
- Use `VectorL10n` generated class for string access
- Run `bundle exec fastlane generate_strings` after changes

## Debugging Tips

### Common Issues
- **Build fails after pull**: Run `pod install` and `xcodegen`
- **Simulator issues**: Clean build folder (Cmd+Shift+K)
- **Matrix SDK changes not reflected**: Update git submodule

### Useful Breakpoints
- `AppCoordinator.start()` - App initialization
- `MXSession.start()` - Matrix session start
- `RoomViewController.viewDidLoad()` - Room screen setup

## CI/CD

GitHub Actions workflows in `.github/workflows/`:
- **ci-tests.yml**: Runs on PRs, executes unit tests
- **release-alpha.yml**: Builds alpha releases for testing
- Pull requests require passing tests before merge