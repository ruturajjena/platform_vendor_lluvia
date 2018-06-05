# Copyright (C) 2018 MiracleDROID
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

PRODUCT_PACKAGES += \
    LLuviaOTA

PRODUCT_PROPERTY_OVERRIDES += \
    ro.lluvia.device=$(PRODUCT_DEVICE) \
    ro.lluvia.ota.version=LLuviaOS-8.1-NATUREMADE-$(PRODUCT_DEVICE)-$(shell date +"%Y%m%d")
