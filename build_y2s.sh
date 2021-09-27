#!/bin/bash

#Cloning
# Clone github.com/exynoobs repos and add commits
cd ~/flos
BRANCH="lineage-18.1"

gitclo(){
  parse=$(echo -n $1 | sed 's/^.*\///; s/_/\//; s/^.*\///; s/_/\//g')
  rm -rf $parse 2>/dev/null
  git clone $1 -b $BRANCH $parse
}

gitclo https://github.com/Exynoobs/android_device_samsung_exynos990-common
#Disable script for kernel temporarily
#gitclo https://github.com/Exynoobs/android_kernel_samsung_exynos990
gitclo https://github.com/Exynoobs/proprietary_vendor_samsung_exynos990-common
gitclo https://github.com/Exynoobs/android_device_samsung_y2s
gitclo https://github.com/Exynoobs/proprietary_vendor_samsung_y2s

# Merge commits
cd device/samsung/exynos990-common &&
git fetch https://github.com/RaySlash/android_device_samsung_exynos990-common-1 $BRANCH &&
git cherry-pick 94310504f610bfc3da0018c5e2cc45a93a6ecd50^..8bd8c0679f323ddcc71a99c2fc9510a35f8b2b16
echo "DEVICE_PACKAGE_OVERLAYS += \\
      \$(COMMON_PATH)/overlay-lineage" >> common.mk
# Random fixes
#rm -rf overlay-lineage/packages/apps/Settings/res/values/config.xml
#mv ~/steve/build/config.xml ~/losr/device/samsung/exynos990-common/overlay-lineage/packages/apps/Settings/res/values/config.xml
git add *
git commit -m "Touchup Fix"
cd ~/flos/

#Building
# Start Jenkins Build
curl -X POST "http://148.251.45.179:8080/job/losr_y2s/buildWithParameters?token=202973ac8406c1c4a99a1487d813b858" --user "RaySlash:11ee81923e81298cdfbc99c489bab7538c"
echo "Build Started!"
echo "JENKINS = http://148.251.45.179:8080/job/losr_y2s/"
