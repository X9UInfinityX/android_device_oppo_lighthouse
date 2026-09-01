#
# Copyright (C) 2021-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

USE_PREBUILT_KERNEL ?= true

# Partitions
BOARD_SUPER_PARTITION_SIZE := 20451426304

# Include the common OEM chipset BoardConfig.
include device/oppo/sm8850-common/BoardConfigCommon.mk

DEVICE_PATH := device/oppo/lighthouse

# Assert
TARGET_OTA_ASSERT_DEVICE := OP61BDL1,OP627CL1

# Display
TARGET_SCREEN_DENSITY := 640

# Kernel
ifeq ($(USE_PREBUILT_KERNEL), true)
include device/oppo/lighthouse-kernel/BoardConfig.mk
else
TARGET_KERNEL_ADDITIONAL_FLAGS += CONFIG_LIGHTHOUSE_DTB=y
endif

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 103

INFINITY_MAINTAINER := koaaN

# Include the proprietary files BoardConfig.
include vendor/oppo/lighthouse/BoardConfigVendor.mk
