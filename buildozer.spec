[app]
# ناوی ئەپەکە بە کوردی
title = ڕێگای ڕاست
package.name = regayrast
package.domain = org.sirat.kurd
source.dir = .
source.include_exts = py,png,jpg,kv,atlas
version = 1.0

# لۆگۆی ئەپەکە
icon.filename = ic_launcher.svg

orientation = portrait
fullscreen = 0

# کتێبخانەکان - وەشانی کیڤی دیاری کراوە بۆ جێگیری
requirements = python3,kivy==2.2.1,pillow

# ڕێکخستنی ئەندرۆید - وەشانی 25b بۆ دوورکەوتنەوە لە کێشە
android.api = 33
android.minapi = 21
android.ndk = 25b
android.ndk_path = 
android.sdk_path = 

# مۆڵەتی ئینتەرنێت
android.permissions = INTERNET

[buildozer]
log_level = 2
warn_on_root = 1
