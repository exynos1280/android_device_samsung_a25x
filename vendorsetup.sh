#!/bin/bash
SCRIPTS_ROOT="$(realpath device/samsung/a25x)"

# SBC HD (Dual Channel) Bluetooth audio patches
# Set SKIP_SBC_HD_PATCHES=1 to disable these patches
if [ "$SKIP_SBC_HD_PATCHES" != "1" ]; then
  echo "-> Checking for SBC HD Bluetooth patches to apply..."

  # packages/modules/Bluetooth patches (must be applied in order)
  if ! grep -q "CHANNEL_MODE_DUAL_CHANNEL" "packages/modules/Bluetooth/framework/java/android/bluetooth/BluetoothCodecConfig.java"; then
    (
      cd "packages/modules/Bluetooth"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_modules_Bluetooth/0001-Add-CHANNEL_MODE_DUAL_CHANNEL-constant.patch"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_modules_Bluetooth/0002-Explicit-SBC-Dual-Channel-SBC-HD-native-stack-suppor.patch"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_modules_Bluetooth/0003-Increase-SBC-HD-bitrates-with-2DH5-fallback-support.patch"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_modules_Bluetooth/0004-Allow-auto-enabling-SBC-HD.patch"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_modules_Bluetooth/0005-Add-force-max-SBC-HD-bitrate-option.patch"
    )
  fi

  # SettingsLib patches (strings for channel mode and toggle)
  if ! grep -qF "Dual Channel (SBC HD)" "frameworks/base/packages/SettingsLib/res/values/arrays.xml" || ! grep -qF "bluetooth_enable_sbc_hd" "frameworks/base/packages/SettingsLib/res/values/strings.xml"; then
    (
      cd "frameworks/base"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/frameworks_base/0001-Add-Dual-Channel-SBC-HD-to-Bluetooth-Audio-Channel-Mode-strings.patch"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/frameworks_base/0002-SettingsLib-Add-SBC-HD-toggle-strings.patch"
    )
  fi

  # packages/apps/Settings patches (channel mode dialog + developer options toggles + crash fix + empty layout fix)
  if ! grep -q "Always populating exactly 4 items" "packages/apps/Settings/src/com/android/settings/development/bluetooth/BluetoothChannelModeDialogPreference.java"; then
    (
      cd "packages/apps/Settings"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_apps_Settings/0001-Add-Dual-Channel-into-Bluetooth-Audio-Channel-Mode-dialog.patch"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_apps_Settings/0002-Settings-Add-SBC-HD-Developer-Options-toggles.patch"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_apps_Settings/0003-Settings-Fix-IndexOutOfBoundsException-in-BaseBluetoothDialogPreference.patch"
      git am -3 "$SCRIPTS_ROOT/patches/SBC_HD/packages_apps_Settings/0004-Settings-Fix-empty-radio-buttons-in-Channel-Mode-dialog.patch"
    )
  fi

  echo "-> SBC HD patches applied."
else
  echo "-> Skipping SBC HD patches (SKIP_SBC_HD_PATCHES=1)"
fi
