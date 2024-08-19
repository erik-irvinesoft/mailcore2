#!/bin/bash
set -ex

# Create reports folder
mkdir -p .build/reports

# Test
swift test -Xcc -DUNIT_TESTS | tee .build/reports/test.log
return_code=${PIPESTATUS[0]}

# Generate junit report
cat .build/reports/test.log | xcpretty --report junit --output .build/reports/junit.xml

# return code
exit ${return_code}
