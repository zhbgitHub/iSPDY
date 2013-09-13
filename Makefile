IOS_SDK ?= iphoneos
SIMULATOR_SDK ?= iphonesimulator
CONFIGURATION ?= Release
LIPO ?= `xcrun -find lipo -sdk $(IOS_SDK)`

all:
	./gyp_ispdy -f xcode -Dsdk=$(IOS_SDK)
	xcodebuild -configuration $(CONFIGURATION)
	./gyp_ispdy -f xcode -Dsdk=$(SIMULATOR_SDK)
	xcodebuild -configuration $(CONFIGURATION)
	$(LIPO) -create ./build/$(CONFIGURATION)-iphoneos/libispdy-bundled.a \
			./build/$(CONFIGURATION)-iphonesimulator/libispdy-bundled.a \
			-output ./build/$(CONFIGURATION)-iphoneos/libispdy-combinded.a

