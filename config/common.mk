PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

PRODUCT_GENERIC_PROPERTIES += \
    keyguard.no_require_sim=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.boot.vendor.overlay.theme=com.google.android.theme.pixel \
    ro.build.selinux=1 \
    ro.setupwizard.mode=OPTIONAL \
    ro.setupwizard.rotation_locked=true \
    persist.sys.disable_rescue=true

# Disable excessive dalvik debug messages
PRODUCT_GENERIC_PROPERTIES += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/lluvia/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/lluvia/prebuilt/common/bin/50-lluvia.sh:system/addon.d/50-lluvia.sh \
    vendor/lluvia/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/lluvia/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# lluvia-specific init file
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/init.local.rc:root/init.lluvia.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/lluvia/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/lluvia/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# lluvia-specific startup services
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/lluvia/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/lluvia/prebuilt/common/bin/sysinit:system/bin/sysinit

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    LockClock \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Prebuilt packages
PRODUCT_PACKAGES += \
    PixelLauncher \
    Launcher3 \
    WallpaperPickerGoogle \
    Turbo

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    LatinIME \
    OmniJaws \
    BluetoothExt \
    Launcher3Dark \
    Poweramp-beta-preview-build-790-uni

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

PRODUCT_PACKAGES += \
    charger_res_images

# Fonts
PRODUCT_PACKAGES += \
    DU-Fonts

# DU Utils library
PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# DU Utils library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/lluvia/prebuilt/common/media/LMspeed_508.emd:system/media/LMspeed_508.emd \
    vendor/lluvia/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# LLuvia OTA
include vendor/lluvia/config/ota.mk

# LLuviaStorm
PRODUCT_PACKAGES += \
    LLuviaStorm

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_GENERIC_PROPERTIES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_GENERIC_PROPERTIES += \
    ro.storage_manager.enabled=true

# easy way to extend to add more packages
-include vendor/extra/product.mk

# Media
PRODUCT_GENERIC_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Packages
PRODUCT_PACKAGES += \
    GBoardDarkTheme \
    SystemUIDarkTheme \
    SettingsDarkTheme \
    SystemDarkTheme \
    PixelTheme \
    Stock

PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/common

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


# Charging sounds
PRODUCT_COPY_FILES += \
    vendor/lluvia/google/effects/BatteryPlugged.ogg:system/media/audio/ui/BatteryPlugged.ogg \
    vendor/lluvia/google/effects/BatteryPlugged_48k.ogg:system/media/audio/ui/BatteryPlugged_48k.ogg

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

PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/common

# Set custom volume steps
PRODUCT_GENERIC_PROPERTIES += \
    ro.config.media_vol_steps=30 \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Versioning System
# LLUVIA first version.
PRODUCT_VERSION_MAJOR = 8.1.0
PRODUCT_VERSION_MINOR = Stable
PRODUCT_VERSION_MAINTENANCE = 1.3
LLUVIA_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
ifdef LLUVIA_BUILD_EXTRA
    LLUVIA_POSTFIX := -$(LLUVIA_BUILD_EXTRA)
endif

ifndef LLUVIA_BUILD_TYPE
    LLUVIA_BUILD_TYPE := MANMADE
endif

ifeq ($(LLUVIA_BUILD_TYPE), Official)
    LLUVIA_BUILD_TYPE := NATUREMADE
endif

# Include SDCLANG definitions if it is requested and available
ifeq ($(HOST_OS),linux)
    ifneq ($(wildcard vendor/qcom/sdclang-4.0/),)
        include vendor/lluvia/sdclang/sdclang.mk
    endif
endif

# Set all versions
LLUVIA_VERSION := LLuvia-$(LLUVIA_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(LLUVIA_BUILD_TYPE)$(LLUVIA_POSTFIX)
LLUVIA_MOD_VERSION := LLuvia-$(LLUVIA_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(LLUVIA_BUILD_TYPE)$(LLUVIA_POSTFIX)

PRODUCT_GENERIC_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    lluvia.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.lluvia.version=$(LLUVIA_VERSION) \
    ro.modversion=$(LLUVIA_MOD_VERSION) \
    ro.lluvia.buildtype=$(LLUVIA_BUILD_TYPE) \

# Google sounds
include vendor/lluvia/google/GoogleAudio.mk

# Unlimited photo storage in Google Photos
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/etc/sysconfig/pixel_2017_exclusive.xml:system/etc/sysconfig/pixel_2017_exclusive.xml

EXTENDED_POST_PROCESS_PROPS := vendor/lluvia/tools/lluvia_process_props.py
