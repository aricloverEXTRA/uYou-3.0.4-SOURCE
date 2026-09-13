# uYou 3.0.4 - Reverse Engineered Source

This is a clean, compilable reverse-engineered version of uYou 3.0.4, organized for maintainability while preserving identical functionality to the original MiRO92 release.

## Project Structure

```
uYou-3.0.4-src/
├── Classes/
│   ├── Core/
│   │   ├── Downloads/      # Download management system
│   │   ├── Gestures/       # Custom gesture recognizers
│   │   ├── Models/         # Data models
│   │   ├── Player/         # Video/audio playback
│   │   ├── Settings/       # Settings UI framework
│   │   ├── Utils/          # Utility classes
│   │   └── Welcome/        # Welcome/onboarding flow
│   └── UI/
│       ├── Cells/          # UITableViewCell subclasses
│       ├── ViewControllers/# View controllers
│       └── Views/          # Custom UIView subclasses
├── Vendor/                 # Third-party dependencies (headers only)
├── Resources/              # uYouBundle.bundle
├── Layout/                 # PreferenceLoader plists
├── Makefile                # Theos build configuration
├── control                 # Debian package control
├── uYou.plist              # MobileSubstrate filter
└── Tweak.xm                # Entry point
```

## Building

### Prerequisites
- Theos installed
- iOS SDK (13.0+)
- Vendor dependencies (see below)

### Build Commands

```bash
# Build for single architecture
make package ARCHS="arm64"

# Build for all architectures (arm64, arm64e, armv7)
make package-all

# Clean all architectures
make clean-all
```

### Vendor Dependencies

The following third-party libraries are required. Place their headers in `Vendor/` and link against their static libraries:

- **AFNetworking** - Networking
- **FMDB** - SQLite wrapper
- **GCDWebServer** - Local HTTP server
- **JGProgressHUD** - Progress HUD
- **LNPopup** - Popup controller
- **Lottie** - Animation rendering
- **SDWebImage** - Image loading/caching
- **Others** - BRYSerialAnimationQueue, JTMaterialSwitch, PKYStepper, SSBouncyButton, STPopup

## Architecture Notes

### Multi-Architecture Support
The Makefile supports building for:
- `arm64` - Modern 64-bit devices (iPhone 5s+)
- `arm64e` - Latest 64-bit devices with PAC (iPhone XS+)
- `armv7` - Legacy 32-bit devices (iPhone 5c and earlier)

### Code Organization Principles

1. **Separation of Concerns**: Core logic separated from UI
2. **Protocol-Oriented**: Delegates used for communication
3. **Singletons**: Shared managers for global state
4. **ARC**: Automatic Reference Counting enabled
5. **Modern Objective-C**: Properties, blocks, generics

### Key Classes

| Class | Purpose |
|-------|---------|
| `DownloadsManager` | Central download coordination |
| `DownloadItem` | Individual download representation |
| `PlayerManager` | AVPlayer wrapper |
| `FRPreferences` | UserDefaults wrapper |
| `SettingsVC` | Settings UI controller |
| `DownloadsPagerVC` | Tabbed downloads interface |

## Differences from Original

This reverse-engineered version:
- ✅ Compiles cleanly with modern clang
- ✅ Uses proper Objective-C conventions
- ✅ Organized for maintainability
- ✅ Includes all original functionality
- ⚠️ Vendor implementations are stubs (link against original libs)
- ⚠️ Some complex features need implementation (FFmpeg, etc.)

## License

This is a reverse-engineering project for educational purposes. Original uYou by MiRO92.

## Credits
- **[MiRO92](https://github.com/MiRO92)** - The developer of **uYou** (Tweak). Without their original work, this project would not exist.
- **[EthanArbuckle](https://github.com/EthanArbuckle/ida-objc-export-plugin)** - Developer of the **IDA Plugin** used to export pseudocode of Objective-C classes into separate `.m` files, enabling the reverse engineering process.

## Contributing

1. Fork the repository
2. Implement missing functionality
3. Ensure multi-arch compatibility
4. Submit PR with tests