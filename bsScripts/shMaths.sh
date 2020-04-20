#!/bin/bash 

arg1=10;
arg2=20;
arg3=0;

# # both non-null;
echo "` expr $arg1 \| $arg2 `";
# first-null;
echo "` expr $arg3 \| $arg2 `";
# second-null;
echo "` expr $arg1 \| $arg3 `";
# both-null;
echo "` expr $arg3 \| $arg3 `";

# both non-null;
echo "` expr $arg1 \& $arg2 `";
# first-null;
echo "` expr $arg3 \& $arg2 `";
# second-null;
echo "` expr $arg1 \& $arg3 `";
# both-null;
echo "` expr $arg3 \| $arg3 `";

# both non-null;
echo `let $arg1 % $arg2`;     # false
# first-null;
echo "` let $arg3 ^ $arg2 `";     # true
# second-null;
echo "` let $arg1 ^ $arg3 `";     # true
# both-null;
echo "` let $arg3 ^ $arg3 `";     # false