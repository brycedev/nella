include theos/makefiles/common.mk

BUNDLE_NAME = Nella
Nella_FILES = Nella.mm
Nella_INSTALL_PATH = /Library/PreferenceBundles
Nella_LIBRARIES = colorpicker
Nella_FRAMEWORKS = UIKit MessageUI
Nella_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Nella.plist$(ECHO_END)
