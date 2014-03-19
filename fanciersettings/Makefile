export ARCHS = armv7 armv7s arm64
include theos/makefiles/common.mk

BUNDLE_NAME = FancierSettings
FancierSettings_FILES = FancierSettings.mm ColorPickerCell.mm GlobalSettingsController.mm HeaderCell.mm KeyBoardCell.mm NavBarCell.mm pickerView.mm TabBarCell.mm TableViewCell.mm AppOverridesMainController.mm
FancierSettings_INSTALL_PATH = /Library/PreferenceBundles
FancierSettings_FRAMEWORKS = UIKit CoreGraphics
FancierSettings_PRIVATE_FRAMEWORKS = Preferences
FancierSettings_LIBRARIES = applist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FancierSettings.plist$(ECHO_END)
