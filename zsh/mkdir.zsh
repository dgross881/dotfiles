#christoomey clean functions to mkdir and cd into it 
function mkcd() { mkdir $1 && cd $1 }
function mkgit() { mkdir $1 && cd $1 && git init }
function mkclone() { git clone $1 && cd $( echo "$1" | sed -E 's|.*/(.*).git$|\1|' ) }

