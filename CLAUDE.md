# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Element iOS is a Matrix messaging client application for iOS built with Swift and Objective-C. The project uses a modular architecture with:
- **MatrixSDK** for Matrix protocol implementation
- **SwiftUI** and **UIKit** for UI components
- **XcodeGen** for project generation
- **CocoaPods** for dependency management

## Build Commands

### Initial Setup
```bash
# Generate Xcode project from YAML configuration
xcodegen

# Install dependencies via CocoaPods
pod install

# OR use the automated setup script that handles everything
./setup_project.sh

# Open the workspace
open Riot.xcworkspace
```

### Common Development Commands
```bash
# Run tests
xcodebuild test -workspace Riot.xcworkspace -scheme Riot -destination 'platform=iOS Simulator,name=iPhone 15'

# Build for Debug
xcodebuild build -workspace Riot.xcworkspace -scheme Riot -configuration Debug

# Build for Release
xcodebuild build -workspace Riot.xcworkspace -scheme Riot -configuration Release

# Clean build
xcodebuild clean -workspace Riot.xcworkspace -scheme Riot

# Run SwiftLint
swiftlint

# Update dependencies
pod update
```

### Fastlane Commands
```bash
# Build Ad Hoc IPA
bundle exec fastlane adhoc

# Build App Store IPA
bundle exec fastlane app_store

# Build Alpha/PR build
bundle exec fastlane alpha

# Deploy to App Store
bundle exec fastlane deploy_release
```

## Architecture

### Core Structure
- **`Riot/`**: Main application target containing app delegate, coordinators, and UI modules
- **`RiotSwiftUI/`**: SwiftUI-based UI components and views
- **`DesignKit/`**: Design system with colors, fonts, and theming
- **`CommonKit/`**: Shared utilities and extensions
- **`RiotNSE/`**: Notification Service Extension for push notifications
- **`BroadcastUploadExtension/`**: Screen recording broadcast extension
- **`matrix-ios-sdk/`**: Local checkout of MatrixSDK (when using local development)

### Key Architectural Patterns

#### Coordinator Pattern
The app uses coordinators for navigation flow management:
- `AppCoordinator`: Root coordinator managing app-level navigation
- `SplitViewCoordinator`: Manages iPad split view navigation
- `TabBarCoordinator`: Manages tab bar navigation
- Module-specific coordinators (e.g., `RoomCoordinator`, `AuthenticationCoordinator`)

#### Service Layer
- `UserSessionsService`: Manages Matrix user sessions
- `PushNotificationService`: Handles push notifications
- `ThemeService`: Manages app theming
- `AnalyticsService`: Handles analytics tracking
- `LocationManager`: Manages location services

#### Data Flow
- MVVM pattern for SwiftUI views
- MVC with coordinators for UIKit views
- Combine framework for reactive programming
- MatrixSDK for Matrix protocol operations

### Module Organization
Each feature module typically contains:
- Coordinator (navigation logic)
- ViewModel (business logic for SwiftUI)
- Views/ViewControllers (UI)
- Models (data structures)
- Bridge presenters (UIKit/SwiftUI interop)

## Configuration

### Build Settings
- Main configuration: `Config/BuildSettings.swift`
- XcodeGen project: `project.yml`
- Target configurations: `*/target.yml`
- Build configs: `Config/Project-*.xcconfig`

### Important Environment Settings
- Homeserver URL: Configured in `BuildSettings.swift`
- Push notification settings: Managed via `pusherAppId` and `pushKitAppId`
- Application group: Used for sharing data between app and extensions

## Development Workflow

### Working with MatrixSDK
To work with a local MatrixSDK:
1. Clone MatrixSDK to `../matrix-ios-sdk`
2. Uncomment `$matrixSDKVersion = :local` in Podfile
3. Run `pod install`

### Testing Changes
1. Run unit tests: `RiotTests/` directory
2. Run UI tests: `RiotSwiftUI/targetUITests.yml`
3. Test on both iPhone and iPad simulators
4. Verify push notifications with a real device

### Code Style
- Swift code follows SwiftLint rules
- Objective-C follows existing patterns
- Use existing UI components from DesignKit
- Follow coordinator pattern for navigation
- Maintain theme support for all new UI

## Key Files and Directories

### Entry Points
- `Riot/Modules/Application/AppDelegate.swift`: Main app delegate
- `Riot/Modules/Application/AppCoordinator.swift`: Root navigation coordinator
- `RiotSwiftUI/RiotSwiftUIApp.swift`: SwiftUI app entry point

### Configuration
- `project.yml`: XcodeGen configuration
- `Podfile`: CocoaPods dependencies
- `Config/BuildSettings.swift`: Runtime build settings
- `Config/AppIdentifiers.xcconfig`: Bundle identifiers

### Localization
- `Riot/Assets/*.lproj/`: Localized strings
- `Riot/Generated/Strings.swift`: Generated string constants

## Debugging Tips

- Use Xcode breakpoints and LLDB for debugging
- Check `MatrixSDKLogger` for Matrix-related logs
- Use FLEX debugger in debug builds (shake device to activate)
- Monitor network requests via Charles Proxy or similar
- Check push notification delivery via Console app

## Important Notes

- Always run `xcodegen` after modifying `project.yml` or `target.yml` files
- Run `pod install` after changing dependencies in Podfile
- The project requires Xcode 12.1+ and Swift 5.x
- Use `setup_project.sh` for automated project setup
- Test on real devices for push notifications and VoIP features