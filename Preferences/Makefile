include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SafariPlusPrefs
SafariPlusPrefs_CFLAGS = -fobjc-arc -D PREFERENCES=1
SafariPlusPrefs_FILES = ../MobileSafari/Classes/SPFileManager.mm ../MobileSafari/Classes/SPFileBrowserTableViewController.mm ../MobileSafari/Classes/SPFileBrowserNavigationController.mm ../MobileSafari/Classes/SPFileTableViewCell.mm ../MobileSafari/Classes/SPFile.mm ../MobileSafari/Classes/SPLocalizationManager.mm
SafariPlusPrefs_FILES += $(wildcard *.mm ../Shared/*.mm)
SafariPlusPrefs_INSTALL_PATH = /Library/PreferenceBundles
SafariPlusPrefs_FRAMEWORKS = UIKit

ifeq ($(NO_LIBCSCOLORPICKER),0)
SafariPlusPrefs_LIBRARIES += cscolorpicker
else
SafariPlusPrefs_CFLAGS += -D NO_LIBCSCOLORPICKER=1
endif

ifeq ($(ROOTLESS),1)
SafariPlusPrefs_CFLAGS += -D ROOTLESS=1
endif

ifeq ($(SIMJECT),1)
dir_string := @"\"$(CURDIR)\""
SafariPlusPrefs_CFLAGS += -D SIMJECT=1 -D CUR_DIR=$(dir_string)
endif

SafariPlusPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SafariPlusPrefs.plist$(ECHO_END)
