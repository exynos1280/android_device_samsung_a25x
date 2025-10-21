#
# Copyright (C) The LineageOS Project
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

# Inherit proprietary files
include vendor/samsung/a25x/BoardConfigVendor.mk

# Inherit board configuration from common tree
include device/samsung/s5e8825-common/BoardConfigCommon.mk

DEVICE_PATH := device/samsung/a25x

# Boot Animation
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_SCREEN_HEIGHT := 2340
TARGET_SCREEN_WIDTH := 1080

# DTBO
BOARD_DTBO_CFG := $(DEVICE_PATH)/configs/a25x.cfg

# FM Radio
BOARD_HAVE_SLSI_FM := true
