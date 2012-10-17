# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# Copyright 2012 LibreOffice contributors.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
 
XCLASSPATH := external/saxon9.jar:$(CLASSPATH)

.PHONY : all clean

all : build/xslt2-transformer.oxt

build/xslt2-transformer.oxt : \
		build/ext/xslt2-transformer.jar \
	   	build/ext/components.rdb \
	   	build/ext/description.xml \
		build/ext/description-en-US.txt \
		build/ext/META-INF/manifest.xml \
		build/ext/saxon9.jar
	rm -f $@ && cd build/ext && zip -r $(abspath $@) .

build/ext/xslt2-transformer.jar : \
		Manifest \
		build/javac.done
	mkdir -p $(dir $@) && \
	cd build/classes && \
	jar -cfm $(abspath $@) $(abspath $<) com

build/javac.done : \
		com/sun/star/comp/xsltfilter/Base64.java \
		com/sun/star/comp/xsltfilter/XSLTFilterOLEExtracter.java \
		com/sun/star/comp/xsltfilter/XSLTransformer.java
	mkdir -p build/classes && \
	javac -d build/classes -source 1.5 -target 1.5 -cp "$(XCLASSPATH)" $(filter %.java,$^) && \
	touch $@

build/ext/% :
	mkdir -p $(dir $@) && cp $< $@

build/ext/components.rdb : components.rdb

build/ext/description.xml : description.xml

build/ext/description-en-US.txt : description-en-US.txt

build/ext/META-INF/manifest.xml : manifest.xml

build/ext/saxon9.jar : external/saxon9.jar

clean :
	rm -rf build

# vim: set noexpandtab shiftwidth=4 tabstop=4:
