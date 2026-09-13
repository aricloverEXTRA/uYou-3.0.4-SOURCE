TARGET = iphone:clang:18.6:14.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = YouTube

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = uYou

# Core source files
uYou_FILES = $(wildcard Classes/**/*.m) $(wildcard Classes/**/*.mm) $(filter-out Vendor/LNPopup/LNPopupControllerExample/% Vendor/Lottie/Example% Vendor/Lottie/Example-Swift/% Vendor/Lottie/lottie-ios/% Vendor/Lottie/MacOS_Viewer/% Vendor/SDWebImage/Examples/% Vendor/SDWebImage/Tests/% Vendor/AFNetworking/Example/% Vendor/AFNetworking/Tests/% Vendor/AFNetworking/UIKit+AFNetworking/% Vendor/GCDWebServer/Tests/% Vendor/FMDB/Tests/% Vendor/SDWebImage/NSBezierPath+SDRoundedCorners.m Vendor/SDWebImage/NSButton+WebCache.m Vendor/SDWebImage/NSImage+Compatibility.m Vendor/SDWebImage/SDAnimatedImageRep.m Vendor/SDWebImage/SDWebImageMapKit/% Vendor/SDWebImage/MKAnnotationView+WebCache.m Vendor/SDWebImage/FLAnimatedImage/%,$(wildcard Vendor/**/*.m) $(wildcard Vendor/**/*.mm))


uYou_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-function
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Classes -I$(THEOS_PROJECT_DIR)/Classes/Core -I$(THEOS_PROJECT_DIR)/Classes/Core/Downloads -I$(THEOS_PROJECT_DIR)/Classes/Core/Gestures -I$(THEOS_PROJECT_DIR)/Classes/Core/Models -I$(THEOS_PROJECT_DIR)/Classes/Core/Player -I$(THEOS_PROJECT_DIR)/Classes/Core/Settings -I$(THEOS_PROJECT_DIR)/Classes/Core/Utils -I$(THEOS_PROJECT_DIR)/Classes/Core/Welcome -I$(THEOS_PROJECT_DIR)/Classes/UI -I$(THEOS_PROJECT_DIR)/Classes/UI/Cells -I$(THEOS_PROJECT_DIR)/Classes/UI/ViewControllers -I$(THEOS_PROJECT_DIR)/Classes/UI/Views -I$(THEOS_PROJECT_DIR)/Vendor
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/AFNetworking
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/FMDB
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/GCDWebServer
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/JGProgressHUD
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/LNPopup
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/LNPopup/LNPopupController
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/LNPopup/LNPopupController/LNPopupController
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/LNPopup/LNPopupController/LNPopupController/Private
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/Lottie
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/MobileFFmpeg
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/Others
uYou_CFLAGS += -I$(THEOS_PROJECT_DIR)/Vendor/SDWebImage

uYou_FRAMEWORKS = UIKit Foundation AVFoundation AVKit Photos CoreMotion VideoToolbox Security MediaPlayer
uYou_LIBRARIES = bz2 c++ iconv z sqlite3

# Bundle is installed via Layout/ to match original deb path: /Library/Application Support/uYouBundle.bundle
# Theos EMBED_BUNDLES would place it under /Library/MobileSubstrate/DynamicLibraries — wrong location


include $(THEOS_MAKE_PATH)/tweak.mk

# Multi-arch build targets
.PHONY: package-all
package-all:
	$(MAKE) package ARCHS="arm64"
	$(MAKE) package ARCHS="arm64e"
	$(MAKE) package ARCHS="armv7"

.PHONY: clean-all
clean-all:
	$(MAKE) clean ARCHS="arm64"
	$(MAKE) clean ARCHS="arm64e"
	$(MAKE) clean ARCHS="armv7"