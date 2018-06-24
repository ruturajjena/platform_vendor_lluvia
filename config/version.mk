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

#LLuviaOS Versioning :
LLUVIA_VERSION = v1.4


ifndef LLUVIA_BUILD_TYPE
    LLUVIA_BUILD_TYPE := MANMADE
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(LLUVIA_OFFICIAL), true)
   LIST = $(shell curl -s https://raw.githubusercontent.com/LLuviaOS/android_vendor_lluvia/llovizna-release/lluvia.devices)
   FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
      LLUVIA_BUILD_TYPE := NATUREMADE
      
    endif
    ifneq ($(IS_OFFICIAL), true)
       LLUVIA_BUILD_TYPE := MANMADE
       $(error Device is not official "$(FOUND)")
    endif

PRODUCT_GENERIC_PROPERTIES += \
    persist.ota.romname=$(TARGET_PRODUCT) \
    persist.ota.version=$(shell date +%Y%m%d) \

persist.ota.manifest=https://raw.githubusercontent.com/LLuviaOS/services_apps_ota/llovizna-release/$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3).xml
endif

LLUVIA_VERSION := LLuviaOS-O-$(LLUVIA_VERSION)-$(CURRENT_DEVICE)-$(LLUVIA_BUILD_TYPE)-$(shell date -u +%Y%m%d)

PRODUCT_GENERIC_PROPERTIES += \
  ro.lluvia.version=$(LLUVIA_VERSION) \
  ro.lluvia.releasetype=$(LLUVIA_BUILD_TYPE) \
  ro.modversion=$(LLUVIA_VERSION)

LLUVIA_DISPLAY_VERSION := LLuviaOS-$(LLUVIA_VERSION)-$(LLUVIA_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.lluvia.display.version=$(LLUVIA_DISPLAY_VERSION)
