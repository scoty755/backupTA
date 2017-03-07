LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := dirtycow
LOCAL_SRC_FILES := \
	dirtycow.c
LOCAL_CFLAGS += -DDEBUG -DSTANDALONE
LOCAL_CFLAGS += -fPIE
LOCAL_LDFLAGS := -fPIE -pie
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
LOCAL_SDK_VERSION := 21
LOCAL_MULTILIB := both
LOCAL_MODULE_STEM_32 := dirtycow32
LOCAL_MODULE_STEM_64 := dirtycow64
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := dumpta
LOCAL_SRC_FILES := dumpta.c
LOCAL_SHARED_LIBRARIES := liblog \
	libutils\
	libcutils
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
LOCAL_CFLAGS := -std=c99
LOCAL_MULTILIB := both
LOCAL_MODULE_STEM_32 := dumpta32
LOCAL_MODULE_STEM_64 := dumpta64
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := cow-run-as
LOCAL_SRC_FILES := \
	run-as.c
LOCAL_SHARED_LIBRARIES := liblog libselinux
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
LOCAL_CFLAGS += -std=c99 -Os
LOCAL_CFLAGS += -fPIE
LOCAL_LDFLAGS += -fPIE -pie
LOCAL_ARM_MODE := thumb
LOCAL_MULTILIB := both
LOCAL_MODULE_STEM_32 := run-as32
LOCAL_MODULE_STEM_64 := run-as64
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := exploitta
LOCAL_SRC_FILES := \
	exploitta.c dirtycow.c
LOCAL_SHARED_LIBRARIES := liblog libselinux
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
LOCAL_CFLAGS += -std=c99 -DDEBUG
LOCAL_CFLAGS += -fPIE
LOCAL_LDFLAGS += -fPIE -pie
LOCAL_MULTILIB := both
LOCAL_MODULE_STEM_32 := exploitta32
LOCAL_MODULE_STEM_64 := exploitta64
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := checkta
LOCAL_SRC_FILES := \
	checkta.c
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
LOCAL_CFLAGS += -fPIE
LOCAL_LDFLAGS += -fPIE -pie
LOCAL_MULTILIB := both
LOCAL_MODULE_STEM_32 := checkta32
LOCAL_MODULE_STEM_64 := checkta64
include $(BUILD_EXECUTABLE)
