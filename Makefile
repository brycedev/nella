include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Nella
Nella_FILES = BDSettingsManager.m Tweak.xm
Nella_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Cydia; killall -9 Preferences"
SUBPROJECTS += nella
include $(THEOS_MAKE_PATH)/aggregate.mk
