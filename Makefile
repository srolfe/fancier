export ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = Fancier FancierBoard
Fancier_FILES = Fancier.xm
FancierBoard_FILES = FancierBoard.xm
Fancier_FRAMEWORKS = UIKit CoreGraphics QuartzCore
FancierBoard_FRAMEWORKS = UIKit CoreGraphics QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += fanciersettings
include $(THEOS_MAKE_PATH)/aggregate.mk
