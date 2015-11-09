include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Nella
Nella_FILES = NellaBackgroundController.m NellaButtonController.m NellaBackgroundCell.m NellaHeaderCell.m NellaMiscController.m NellaRootController.m
Nella_INSTALL_PATH = /Library/PreferenceBundles
Nella_FRAMEWORKS = UIKit MessageUI
Nella_PRIVATE_FRAMEWORKS = Preferences
Nella_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Nella.plist$(ECHO_END)
