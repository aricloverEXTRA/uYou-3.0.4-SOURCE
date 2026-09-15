# uYou 3.0.6 (Unofficial) — Reverse Engineered Source

Unofficial continuation of uYou 3.0.4 with native 21.29.3+ fixes. Not endorsed or made by MiRO92.

- **uYou tab** — native `YTPivotBarView` hook (`com.miro.uyouunofficial`, `DownloadsPagerVC`) — no badge hacks
- **SABR fallback** — on-device SABR engine (`Classes/Core/Downloads/UYTSABR.xm` for YouTube 21.29.3+ where innertube returns `-1002`
- **FFmpegKitNext** — `Classes/Core/MediaKit/UYTMediaKit.h/.m` wrapper (FFmpegKitNext-only, no MobileFFmpeg fallback) + `Vendor/ffmpegkit.framework` + `libav*`
- **Rebrand** — `uYouUnofficial` dylib + `uYouUnofficial.bundle` + `com.miro.uyouunofficial`, Settings footer disclaimer, `3.0.6-unofficial`

Original uYou 3.0.4 by MiRO92 — this is a clean, compilable reverse-engineered base, now with the above Unofficial additions.

## Project Structure

```
uYou-3.0.4-src-main/
├── Classes/
│   ├── Core/
│   │   ├── Downloads/      # Download management + UYTSABR (SABR fallback, 21.29.3+)
│   │   ├── Gestures/       # Custom gesture recognizers
│   │   ├── MediaKit/       # UYTMediaKit (FFmpegKitNext wrapper)
│   │   ├── Models/         # Data models
│   │   ├── Player/         # Video/audio playback
│   │   ├── Settings/       # Settings UI framework
│   │   ├── Utils/          # Utility classes
│   │   └── Welcome/        # Welcome/onboarding flow
│   └── UI/
│       ├── Cells/          # UITableViewCell subclasses
│       ├── ViewControllers/# View controllers (DownloadsPagerVC)
│       └── Views/          # Custom UIView subclasses
├── Vendor/                 # Third-party deps + ffmpegkit.framework + libav*
├── Layout/Library/Application Support/
│   ├── uYouUnofficial.bundle/   # was uYouBundle.bundle
│   └── uYouLocalization.bundle/ # kept as-is
├── Makefile                # TWEAK_NAME = uYouUnofficial, TARGET 15.0
├── control                 # com.miro.uyouunofficial, uYou Unofficial 3.0.6
├── uYouUnofficial.plist    # MobileSubstrate filter (was uYou.plist)
└── Tweak.xm                # Entry point (YTPivotBarView → com.miro.uyouunofficial)
```

## Building

### Prerequisites
- Theos installed
- **iOS 15+ SDK recommended** (Xcode 15+ / iOS 15 SDK or newer; `TARGET = iphone:clang:18.6:15.0`)
- Vendor dependencies (see below) — all compatible with iOS 15+ SDK as-is

> **Note:** Deployment target is a minimum. Vendors targeting iOS 8–11 (AFNetworking, SDWebImage, Lottie 2.5.3, etc.) compile clean on iOS 15+ SDK with no changes. Lottie 2.5.3 (ObjC) is kept intentionally — no Swift bridging needed; bundle JSONs remain compatible.

### Build Commands

```bash
# Build for single architecture
make package ARCHS="arm64"

# Build for all architectures (arm64, arm64e, armv7)
make package-all

# Clean all architectures
make clean-all
```

### UYTSABR (21.29.3+ SABR fallback)

Stitchable 3-part engine for YouTube 21.29.3+ (`-1002` fallback):

```bash
cat Classes/Core/Downloads/UYTSABR_Part1.xm Classes/Core/Downloads/UYTSABR_Part2.xm Classes/Core/Downloads/UYTSABR_Part3.xm > Classes/Core/Downloads/UYTSABR.xm
# Wildcard uYou_FILES picks up UYTSABR.xm automatically; remove _Part*.xm after
```

### Vendor Dependencies

Vendored in `Vendor/` (all iOS 15+ SDK compatible as-is, no updates needed):

- **AFNetworking 4.0.1** (iOS 9+) — Networking
- **FMDB 2.7.8** (iOS 11+) — SQLite wrapper
- **GCDWebServer 3.5.4** (iOS 8+) — Local HTTP server
- **JGProgressHUD 2.2** (iOS 8+) — Progress HUD (uses LOTAnimationView)
- **LNPopup** — Popup controller
- **Lottie 2.5.3** (iOS 8+, ObjC) — Animation rendering (kept intentionally; iOS 18 era would be 4.4.3 Swift, but 2.5.3 is stable on iOS 15+ SDK, no Swift bridging needed)
- **SDWebImage 5.12.0** (iOS 9+) — Image loading/caching
- **ffmpegkit.framework + libavcodec/libavdevice/libavfilter/libavformat/libavutil/libswresample/libswscale** — FFmpegKitNext (iOS 12+)
- **Others** — BRYSerialAnimationQueue, JTMaterialSwitch, PKYStepper, SSBouncyButton, STPopup

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

## Differences from Original (Unofficial 3.0.6)

This Unofficial build:
- ✅ Compiles cleanly with modern clang (iOS 15+ SDK recommended)
- ✅ Uses proper Objective-C conventions, organized for maintainability
- ✅ Includes all original uYou 3.0.4 functionality
- ✅ **uYou tab** — native pivot (`com.miro.uyouunofficial`) with `DownloadsPagerVC`
- ✅ **SABR fallback** — on-device SABR for YouTube 21.29.3+ (`-1002` / empty URLs)
- ✅ **FFmpegKitNext** — `UYTMediaKit` wrapper + embedded `ffmpegkit`/`libav*` frameworks
- ✅ **Rebrand** — `uYouUnofficial` dylib/bundle, `com.miro.uyouunofficial`, `3.0.6-unofficial`, Settings disclaimer (“Not endorsed or made by MiRO92”)
- ⚠️ Vendor implementations are stubs (link against original libs where needed)

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