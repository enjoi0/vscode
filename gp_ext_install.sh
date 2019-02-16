#!/bin/bash

pids=""

for PKG in $(cat ./gp_ext.list); do
   code --install-extension $PKG
   pids="$pids $!"
done

wait $pids
