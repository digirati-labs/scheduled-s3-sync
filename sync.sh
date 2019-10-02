#!/bin/sh

echo "Synchronising $SOURCE and $TARGET"
aws sync cp $SOURCE $TARGET

echo "Done"
