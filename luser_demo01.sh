#!/bin/bash

echo "Hello"

WORD='script'
echo "$WORD"

##Demonstrate that single quote do not expand
echo '$WORD'

echo "This is a shell ${WORD}"

ENDING='ed'
echo "This is ${WORD}${ENDING}"
