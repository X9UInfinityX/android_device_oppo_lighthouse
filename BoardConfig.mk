#
# Copyright (C) 2021-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Partitions
BOARD_SUPER_PARTITION_SIZE := 20451426304

# Include the common OEM chipset BoardConfig.
include device/oppo/sm8850-common/BoardConfigCommon.mk

DEVICE_PATH := device/oppo/lighthouse

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Assert
TARGET_OTA_ASSERT_DEVICE := OP61BDL1,OP627CL1

# Display
TARGET_SCREEN_DENSITY := 640

# Kernel
TARGET_KERNEL_BAZEL_FLAGS += --//vendor/oneplus/sm8850:dtbo_config=//vendor/oneplus/sm8850-devicetrees:dengta_dtbo_config

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 103

INFINITY_MAINTAINER := koaaN

# Include the proprietary files BoardConfig.
include vendor/oppo/lighthouse/BoardConfigVendor.mk
