#!/bin/bash
VERSION=$1
echo `kubectl patch deployment myweb -p   '{"spec":{"template":{"spec":{"image":$registry:$VERSION}}}}'`

