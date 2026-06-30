#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.fixups_lib import (
    lib_fixups_user_type,
)

namespace_imports = [
    'device/samsung/s5e8825-common',
    'hardware/samsung',
    'hardware/samsung_slsi-linaro/exynos',
    'hardware/samsung_slsi-linaro/graphics',
    'hardware/samsung_slsi-linaro/interfaces',
    'vendor/samsung/s5e8825-common',
]

blob_fixups: blob_fixups_user_type = {
    # Camera
    'vendor/lib64/libexynoscamera3.so': blob_fixup()
        .add_needed('libshim_camera.so')
        .binary_regex_replace(b'_ZN7android5Fence', b'_ZN7exynos55Fence'),
    # Audio - Effects
    'vendor/etc/floating_feature.xml': blob_fixup().regex_replace(
        r'(?m)^</SecFloatingFeatureSet>$',
        '    <SEC_FLOATING_FEATURE_AUDIO_CONFIG_SOUNDBOOSTER_LIB_VERSION>1100</SEC_FLOATING_FEATURE_AUDIO_CONFIG_SOUNDBOOSTER_LIB_VERSION>\n'
        '</SecFloatingFeatureSet>',
    ),
    'vendor/lib64/soundfx/libsamsungSoundbooster_plus.so': blob_fixup()
        # Fix SB_init state initialization
        # Before: [mov w8,#2]
        # After: [mov w8,#1]
        .sig_replace('19 02 00 94 48 00 80 52', '19 02 00 94 28 00 80 52')
        # Fix SB_process copy size for float stereo PCM
        # Before: [lsl x2,x8,#2]
        # After: [lsl x2,x8,#3]
        .sig_replace('02 f5 7e d3', '02 f1 7d d3'),
    'vendor/lib64/soundfx/libaudiosaplus_sec.so': blob_fixup()
        # Fix default device initialization to trigger Set_Speaker_Output on setDevice(2)
        # Before: [format 5, device 2]
        # After: [format 5, device 0]
        .sig_replace('05 00 00 00 02 00 00 00', '05 00 00 00 00 00 00 00'),
}  # fmt: skip

module = ExtractUtilsModule(
    'a25x',
    'samsung',
    namespace_imports=namespace_imports,
    add_firmware_proprietary_file=True,
    blob_fixups=blob_fixups,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 's5e8825-common', module.vendor
    )
    utils.run()
