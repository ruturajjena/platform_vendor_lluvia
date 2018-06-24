# Copyright (C) 2018 Project LLuviaOS 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# include definitions for SDCLANG
# include vendor/lluvia/sdclang/sdclang.mk


PRODUCT_BRAND ?= LLuviaOS

include vendor/lluvia/config/version.mk

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/lluvia/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/lluvia/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

# Bootanimation
# Boot animation include
ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/lluvia/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

ifeq ($(TARGET_BOOTANIMATION_HALF_RES),true)
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif
endif

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# Device Overlays
DEVICE_PACKAGE_OVERLAYS += \
    vendor/lluvia/overlay/common \
    vendor/lluvia/overlay/dictionaries

# EXT4/F2FS format script
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/format.sh:install/bin/format.sh

# Prebuilt packages
PRODUCT_PACKAGES += \
    PixelLauncher \
    Launcher3 \
    WallpaperPickerGoogle \
    Turbo

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# LLuviaStorm
PRODUCT_PACKAGES += \
    LLuviaStorm

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    LatinIME \
    OmniJaws \
    BluetoothExt \
    Launcher3Dark 

# Fonts
PRODUCT_PACKAGES += \
    DU-Fonts

# Packages
PRODUCT_PACKAGES += \
    GBoardDarkTheme \
    SystemUIDarkTheme \
    SettingsDarkTheme \
    SystemDarkTheme \
    PixelTheme \
    Stock

# Overlays
# BlackAF Theme
PRODUCT_PACKAGES += \
    DuiBlackAF \
    GBoardBlackAF \
    SettingsBlackAF \
    SystemBlackAF \
    UpdaterBlackAF \

# Accents
PRODUCT_PACKAGES += \
    AmberAccent \
    BlackAccent \
    BlueAccent \
    BlueGreyAccent \
    BrownAccent \
    CyanAccent \
    DeepOrangeAccent \
    DeepPurpleAccent \
    GreenAccent \
    GreyAccent \
    IndigoAccent \
    LightBlueAccent \
    LightGreenAccent \
    LimeAccent \
    OrangeAccent \
    PinkAccent \
    PurpleAccent \
    RedAccent \
    TealAccent \
    YellowAccent \
    WhiteAccent

# Extra tools
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    7z \
    bzip2 \
    curl \
    lib7z \
    powertop \
    pigz \
    tinymix \
    unrar \
    unzip \
    zip

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/lluvia/config/permissions/backup.xml:system/etc/sysconfig/backup.xml


# init.d support
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner

# LLuviaOS-specific init file
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/init.local.rc:root/init.lluvia.rc

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/lluvia/prebuilt/common/media/LMspeed_508.emd:system/media/LMspeed_508.emd \
    vendor/lluvia/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/lluvia/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl
    
# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

# easy way to extend to add more packages
-include vendor/extra/product.mk

# Media
PRODUCT_GENERIC_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Needed by some RILs and for some Gapps packages
PRODUCT_PACKAGES += \
    librsjni \
    libprotobuf-cpp-full

# Charger images
PRODUCT_PACKAGES += \
    charger_res_images

# Charging sounds
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/media/audio/BatteryPlugged.ogg:system/media/audio/ui/BatteryPlugged.ogg \
    vendor/lluvia/prebuilt/common/media/audio/BatteryPlugged_48k.ogg:system/media/audio/ui/BatteryPlugged_48k.ogg

# Set custom volume steps
PRODUCT_GENERIC_PROPERTIES += \
    ro.config.media_vol_steps=30 \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Google sounds
include vendor/lluvia/google/GoogleAudio.mk

# Unlimited photo storage in Google Photos
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/etc/sysconfig/pixel_2017_exclusive.xml:system/etc/sysconfig/pixel_2017_exclusive.xml

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG ?= false

#Telephony
$(call inherit-product, vendor/lluvia/config/telephony.mk)

# lluvia_props
$(call inherit-product, vendor/lluvia/config/lluvia_props.mk)

# Enable ADB authentication
ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
endif
