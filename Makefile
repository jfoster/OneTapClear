export ARCHS = armv7 arm64
export DEBUG = 0
export FINALPACKAGE = 0
export TARGET = iphone

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = OneTapClear
OneTapClear_FILES = $(wildcard *.x*)
OneTapClear_OBJCFLAGS = -fno-objc-arc -Wall -ferror-limit=0

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
