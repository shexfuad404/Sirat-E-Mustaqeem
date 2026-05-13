[app]
# ناوی بەرنامەکە بە کوردی
title = ڕێگای ڕاست
package.name = regayrast
package.domain = org.sirat.kurd
source.dir = .
source.include_exts = py,png,jpg,kv,atlas
version = 1.0

# لۆگۆی بەرنامەکە (دڵنیابە فایلێک بەم ناوە لە گیتھەب هەبێت)
icon.filename = logo.png

orientation = portrait
fullscreen = 0

# پێداویستییەکان
requirements = python3,kivy==2.2.1,pillow

# ڕێکخستنی ئەندرۆید - وەشانی ٣١ جێگیرترە بۆ AIDL
android.api = 31
android.minapi = 21
android.sdk = 31
android.build_tools_version = 31.0.0
android.ndk = 25b
android.accept_sdk_license = True

# مۆڵەتەکان
android.permissions = INTERNET

[buildozer]
log_level = 2
warn_on_root = 1
