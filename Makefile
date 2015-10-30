# export DEBUG = 1
# export GO_EASY_ON_ME = 1

export THEOS_BUILD_DIR = build

export ARCHS = armv7 arm64
export TARGET = iphone:clang
export SDKVERSION = 8.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = OneTapClear
OneTapClear_FILES = Tweak.xm
OneTapClear_OBJCFLAGS = -fno-objc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
