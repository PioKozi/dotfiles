#!/usr/bin/env bash

# for license

# setting default values
if [[ -z "${EDITOR}" ]]; then
    EDITOR=vi
fi
if [[ -z "${FILE_FORMAT}" ]]; then
    FILE_FORMAT="+%d-%m-%Y"
fi
if [[ -z "${FILE_SUFFIX}" ]]; then
    FILE_SUFFIX="md"
fi
if [[ -z "${JOURNALLING_DIR}" ]]; then
    JOURNALLING_DIR="$HOME/.local/share/journal"
fi


# making $JOURNALLING_DIR directory if it does not exist
if ! [[ -d $JOURNALLING_DIR ]]; then
    mkdir -p $JOURNALLING_DIR
fi


TODAYENTRY="$(date "$FILE_FORMAT").$FILE_SUFFIX"

if ! [[ -f $JOURNALLING_DIR/$TODAYENTRY ]]; then
    YESTERDAYENTRY="$(/usr/bin/ls $JOURNALLING_DIR/ -t | head -n1)"
    if ! [[ -f $JOURNALLING_DIR/$YESTERDAYENTRY ]]; then
        $EDITOR "$JOURNALLING_DIR/$TODAYENTRY"
    else
        cp $JOURNALLING_DIR/$YESTERDAYENTRY $JOURNALLING_DIR/$TODAYENTRY
        $EDITOR "$JOURNALLING_DIR/$TODAYENTRY"
    fi
else
    $EDITOR "$JOURNALLING_DIR/$TODAYENTRY"
fi


# Copyright © 2020 <Piotr Kozicki>

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
