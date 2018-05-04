#!/bin/sh
echo "
import sys
paths = [path for path in sys.path if path and 'packages' in path]
with open('/tmp/sitecustomize.py', 'wt', encoding='utf8') as fh:
    fh.write('import sys\\\\n')
    for path in paths:
        fh.write('sys.path.append({})\\\\n'.format(repr(path)))
" > /tmp/gen_sitecustomize.py
/usr/bin/python3 /tmp/gen_sitecustomize.py
/usr/bin/zip --junk-paths /tmp/extrapaths.zip /tmp/sitecustomize.py
export PATHFIXER=/tmp/extrapaths.zip
exec "$SNAP/usr/bin/python3" "$SNAP/bin/fades" "$@"
