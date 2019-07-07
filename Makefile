build: 
	swift build

install: 
	swift package resolve

test: 
	swift test

xcode:
	swift package generate-xcodeproj

start: 
	./.build/x86_64-apple-macosx/debug/Teapot start

setup: 
	./.build/x86_64-apple-macosx/debug/Teapot setup
