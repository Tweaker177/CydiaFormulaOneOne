ARCHS = armv7 arm64
TARGET = iphone:clang:9.0:9.0
#CFLAGS = -fobjc-arc
#THEOS_PACKAGE_DIR_NAME = debs

include theos/makefiles/common.mk

TWEAK_NAME = CydiaFormulaOneOne
CydiaFormulaOneOne_FILES = Tweak.xm
CydiaFormulaOneOne_FRAMEWORKS = UIKit
CydiaFormulaOneOne_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += CydiaFormulaOneOne
include $(THEOS_MAKE_PATH)/aggregate.mk
