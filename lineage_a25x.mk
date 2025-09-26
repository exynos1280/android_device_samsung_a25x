#
# Copyright (C) The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from a25x device
$(call inherit-product, device/samsung/a25x/device.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Gapps support
WITH_GMS ?= false

ifeq ($(WITH_GMS),true)
# Inherit from GMS product config
$(call inherit-product-if-exists, vendor/google/gms/config.mk)
$(call inherit-product-if-exists, vendor/google/pixel/config.mk)
endif

# Device identifier, this must come after all inclusions
PRODUCT_DEVICE := a25x
PRODUCT_NAME := lineage_a25x
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A256E
PRODUCT_MANUFACTURER := samsung
PRODUCT_SHIPPING_API_LEVEL := 34
PRODUCT_CHARACTERISTICS := phone

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="a25xdxx-user 15 AP3A.240905.015.A2 A256EXXS8CYG3 release-keys" \
    BuildFingerprint=samsung/a25xdxx/essi:15/AP3A.240905.015.A2/A256EXXS8CYG3:user/release-keys \
    DeviceProduct=a25xdxx \
    SystemName=a25xdxx
