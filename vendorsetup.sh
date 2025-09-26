#!/bin/bash

if [ -f "vendor/google/pixel/Android.bp" ] && grep -q "SystemUIClocks-BigNum" "vendor/google/pixel/Android.bp"; then
  echo "Removing SystemUIClock modules from vendor/google/pixel..."

  perl -0pe 's/android_app_import \{[^}]*name: "SystemUIClocks-[^}]*\}[^}]*\}//gms; s/\n{3,}/\n\n/g' "vendor/google/pixel/Android.bp" > "vendor/google/pixel/Android.bp.tmp" && mv "vendor/google/pixel/Android.bp.tmp" "vendor/google/pixel/Android.bp"

  echo "SystemUIClock modules removed."
fi
