#! /bin/bash 
set -eu
set -o pipefail

PWD=`dirname $0`
APP_DIR="$PWD/../../"

cd $APP_DIR
sourcery --sources ./Sources/TeapotCore/ --templates ./templates/sourcery/AutoMockable.stencil --output ./Tests/TeapotCoreTests/Mock.generated.swift 
