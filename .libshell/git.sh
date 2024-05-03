
function gitsubdir() {
   # Copy a certain path from a remote Git repository.
   REPO=$1
   TARGET=$2
   git clone --depth 1 --filter=blob:none --no-checkout $REPO
   git archive --format=tar HEAD:samples | tar -x -C $TARGET
}
