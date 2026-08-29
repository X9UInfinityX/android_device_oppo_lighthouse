#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from lighthouse device
$(call inherit-product, device/oppo/lighthouse/device.mk)

# Inherit some common Lineage stuff.
INFINITY_MAINTAINER := koaaN

$(call inherit-product, vendor/infinity/config/common_full_phone.mk)

PRODUCT_NAME := lineage_lighthouse
PRODUCT_DEVICE := lighthouse
PRODUCT_MANUFACTURER := OPPO
PRODUCT_BRAND := OPPO
PRODUCT_MODEL := CPH2841

PRODUCT_GMS_CLIENTID_BASE := android-oppo

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="qssi_64-user 16 BP2A.250605.015 1782811448466 release-keys" \
    BuildFingerprint=OPPO/CPH2841IN/OP627CL1:16/BP2A.250605.015/B.R4T2.29f5fc9-54e8c2-574b37:user/release-keys \
    DeviceName=OP627CL1 \
    DeviceProduct=CPH2841 \
    SystemDevice=OP627CL1 \
    SystemName=CPH2841
