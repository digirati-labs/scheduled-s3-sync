#!/bin/sh

echo "Synchronising $SOURCE and $TARGET"
aws s3 cp $SOURCE $TARGET

echo "Done"
