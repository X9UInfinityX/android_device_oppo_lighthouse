# Plus Key integration for OPlus devices

This directory contains a platform-signed Plus Key settings app and action
handler. In this tree it is built for `lighthouse`, but neither the app nor the
framework helper uses a device codename, model number, brand string, or product
property allowlist.

The implementation has four parts:

1. `parts/PlusKey/` provides the user interface and action dispatcher.
2. `device.mk` installs the `PlusKey` module in `system_ext`.
3. `patches/0001-frameworks-base-oplus-pluskey.patch` routes
   `KEYCODE_ASSIST` events from `PhoneWindowManager` to the app.
4. `patches/0002-settings-pluskey-entry.patch` adds a Settings homepage
   entry that is visible only when the privileged app is installed.

The physical side button must report `KEYCODE_ASSIST`. If a device reports a
different key code, give it an appropriate keylayout mapping before using this
integration.

## App

The app is built from source, signed with the platform certificate, installed
as a privileged `system_ext` app, and granted its privileged permissions by
`com.oplus.pluskey.xml`.

It has no launcher entry. On first use, pressing the side key opens the action
picker. The bundled Settings patch also launches it with:

```xml
<intent
    android:action="com.oplus.pluskey.SETTINGS"
    android:targetPackage="com.oplus.pluskey" />
```

The handler accepts these package-targeted broadcasts:

| Action | Purpose |
|---|---|
| `com.oplus.pluskey.SHORT_PRESS` | Run the configured short-press action |
| `com.oplus.pluskey.LONG_PRESS` | Run the configured long-press action |
| `com.oplus.pluskey.CAMERA_TRIGGER_DOWN` | Begin camera shutter handling |
| `com.oplus.pluskey.CAMERA_TRIGGER_UP` | Finish camera shutter handling |

## Generic framework integration

Apply the bundled framework patch from the Android source root:

```sh
git -C frameworks/base apply \
    ../../device/oppo/lighthouse/patches/0001-frameworks-base-oplus-pluskey.patch
git -C packages/apps/Settings apply \
    ../../../device/oppo/lighthouse/patches/0002-settings-pluskey-entry.patch
```

The helper is named `OplusPlusKey`. Its `isAvailable(Context)` check looks
for the enabled, privileged `com.oplus.pluskey` system package. It does not
check device codenames, regional model names, or product properties.

This package-based capability check lets a shared `frameworks/base` build work
across devices:

- Products that include `PlusKey` route `KEYCODE_ASSIST` to the app.
- Products that do not include it keep the normal Android Assist-key behavior.
- A sideloaded app cannot activate the interception because the package must be
  a privileged system app.

The Settings preference uses the same capability model, so a shared Settings
build does not show a dead Plus Key entry on products that omit the app.

The framework patch handles short press, long press, and camera-style key down
and key up events. It also enables long-press recognition while PlusKey is
available, even if the legacy Assist long-press action is disabled.

## Lineage hardware-key overlay

The lighthouse Lineage overlay sets:

```xml
<integer name="config_deviceHardwareKeys">64</integer>
<integer name="config_deviceHardwareWakeKeys">64</integer>
```

This keeps the volume-rocker capability while hiding the legacy Assist-key
controls. PlusKey owns the Assist event path once the framework patch is
applied.

For another device tree, include the app in that product and apply the same
overlay change only if its hardware-key bitmask also exposes the legacy Assist
controls.

## Verification

After building and flashing:

```sh
adb shell pm list packages -s | grep com.oplus.pluskey
adb shell dumpsys package com.oplus.pluskey | grep -E \
    'codePath|pkgFlags|privateFlags'
adb logcat -s OplusPlusKey PlusKey
```

Press and release the programmable side key and verify that
`OplusPlusKey` logs the broadcast and `PlusKey` logs the selected action.

To open the picker directly:

```sh
adb shell am start -a com.oplus.pluskey.SETTINGS -p com.oplus.pluskey
```

If no events appear, use `adb shell getevent -l` and confirm that the hardware
key reaches Android as `KEY_ASSIST`/`KEYCODE_ASSIST`.
