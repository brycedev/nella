include theos/makefiles/common.mk

ARCHS = armv7 arm64

TWEAK_NAME = Nella
Nella_FILES = Tweak.xm
Nella_LIBRARIES = colorpicker
Nella_FRAMEWORKS = Foundation UIKit CoreGraphics QuartzCore
Nella_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Cydia"
SUBPROJECTS += nella
include $(THEOS_MAKE_PATH)/aggregate.mk
