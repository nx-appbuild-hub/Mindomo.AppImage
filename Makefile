# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
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
PWD:=$(shell pwd)


all: clean
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/mindomo
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0
	echo "LD_LIBRARY_PATH=\$${LD_LIBRARY_PATH}:\$${APPDIR}/discord" >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "export LD_LIBRARY_PATH=\$${LD_LIBRARY_PATH}" >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "exec \$${APPDIR}/mindomo/mindomo \"\$${@}\"" >> $(PWD)/build/Boilerplate.AppDir/AppRun

	rm -f $(PWD)/build/Boilerplate.AppDir/*.png | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.desktop	| true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.svg | true	

	wget --output-document=$(PWD)/build/Mindomo.AppImage "https://www.mindomo.com/download/9.4/Mindomo_v.9.4.7_x64.AppImage"
	chmod +x $(PWD)/build/Mindomo.AppImage
	cd $(PWD)/build && $(PWD)/build/Mindomo.AppImage --appimage-extract

	cp --force --recursive $(PWD)/build/squashfs-root/usr/share/* $(PWD)/build/Boilerplate.AppDir/share | true
	cp --force --recursive $(PWD)/build/squashfs-root/usr/lib/* $(PWD)/build/Boilerplate.AppDir/lib64 | true

	rm -rf $(PWD)/build/squashfs-root/usr

	rm -rf $(PWD)/build/Boilerplate.AppDir/etcher/AppRun | true
	rm -rf $(PWD)/build/Boilerplate.AppDir/etcher/*.svg | true
	rm -rf $(PWD)/build/Boilerplate.AppDir/etcher/*.png | true

	mv $(PWD)/build/squashfs-root/*.desktop $(PWD)/build/Boilerplate.AppDir	 | true
	cp --force --recursive $(PWD)/build/squashfs-root/* $(PWD)/build/Boilerplate.AppDir/mindomo
	cp --force $(PWD)/build/Boilerplate.AppDir/share/icons/hicolor/1024x1024/apps/*.png $(PWD)/build/Boilerplate.AppDir | true
	cp --force $(PWD)/build/Boilerplate.AppDir/share/icons/hicolor/scalable/apps/*.svg $(PWD)/build/Boilerplate.AppDir | true
	
	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Mindomo.AppImage
	chmod +x $(PWD)/Mindomo.AppImage

clean:
	rm -rf $(PWD)/build

