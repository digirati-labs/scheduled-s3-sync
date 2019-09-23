#!/bin/sh

echo "Synchronising $SOURCE and $TARGET"
aws s3 sync $SOURCE $TARGET

echo "Done"
