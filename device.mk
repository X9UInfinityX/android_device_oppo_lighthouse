#
# Copyright (C) 2021-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_module_config_primary.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/audio_module_config_primary.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 3168
TARGET_SCREEN_WIDTH := 1440

# OPlus Camera
$(call inherit-product-if-exists, device/oppo/lighthouse-camera/opluscamera.mk)

# Display
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/displayconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630947090715748499.xml

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint3-service.strongbox.nxp \
    android.hardware.weaver-service.nxp

# LiveDisplay
$(call soong_config_set_bool,OPLUS_LINEAGE_LIVEDISPLAY_HAL,ENABLE_SE,false)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    FrameworksResEuicc \
    OPlusFrameworksResTarget \
    OPlusSettingsProviderResTarget \
    OPlusSettingsResTarget \
    OPlusSystemUIResTarget \
    OPlusWifiResTarget \
    PlusKey

# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.powershare-service.oplus

# Properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.build.version.ota=CPH2841_11.A.61_0610_202607061821

# Recovery
$(call soong_config_set_bool,recovery,target_recovery_uses_qti_drm,true)

# Regional properties
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25021/build.default.prop:$(TARGET_COPY_OUT_ODM)/etc/25021/build.default.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25022/build.default.prop:$(TARGET_COPY_OUT_ODM)/etc/25022/build.default.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25211/build.EU.prop:$(TARGET_COPY_OUT_ODM)/etc/25211/build.EU.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25211/build.IN.prop:$(TARGET_COPY_OUT_ODM)/etc/25211/build.IN.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25211/build.default.prop:$(TARGET_COPY_OUT_ODM)/etc/25211/build.default.prop

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Telephony
PRODUCT_PACKAGES += \
    OplusEsimSwitcher \
    OplusEuicc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.mep.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.mep.xml \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

# Touch features
$(call soong_config_set_bool,OPLUS_LINEAGE_TOUCH_HAL,ENABLE_GM,true)

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

$(call soong_config_set_bool,qti_vibrator,use_effect_stream,true)
$(call soong_config_set,qti_vibrator,effect_lib,libqtivibratoreffect.oplus.lighthouse)

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/oppo/sm8850-common/common.mk)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/oppo/lighthouse/lighthouse-vendor.mk)
