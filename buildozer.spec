[app]

# (str) Title of your application
title = ڕێگای ڕاست

# (str) Package name
package.name = sirat_rast

# (str) Package domain (needed for android packaging)
package.domain = org.test

# (str) Source code where the main.py lives
source.dir = .

# (list) Source files to include (let empty to include all the files)
source.include_exts = py,png,jpg,kv,atlas

# (str) Application versioning
version = 0.1

# (str) Custom source for the icon
# لێرەدا ناوی لۆگۆکەت بنووسە کە لە گیتھەب دامانناوە
icon.filename = logo.png

# (list) Permissions
android.permissions = INTERNET

# (str) Supported orientation (landscape, portrait or all)
orientation = portrait

# (bool) Indicate if the application should be fullscreen or not
fullscreen = 0

# (list) Application requirements
# ئەگەر پڕۆژەکەت کتێبخانەی تری تێدایە لێرە زیادی بکە
requirements = python3,kivy

# (str) Android logcat filters to use
android.logcat_filters = *:S python:D

# (int) Android API to use
android.api = 31

# (int) Minimum API your APK will support
android.minapi = 21

# (str) Android NDK version to use
android.ndk = 23b

# (str) Android SDK directory
#android.sdk_path = 

# (str) Android NDK directory
#android.ndk_path = 

[buildozer]
# (int) Log level (0 = error only, 1 = info, 2 = debug (with command output))
log_level = 2

# (int) Display warning if buildozer is run as root (0 = off, 1 = on)
warn_on_root = 1
