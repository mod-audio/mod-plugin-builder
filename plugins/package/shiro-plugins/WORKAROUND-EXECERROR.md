Workaround for exec error while compiling:

add "-qemu-arm" to "dpf/utils/generate-ttl.sh" like in this example below.

----------------------------------------------------
for i in $FOLDERS; do
  cd $i
  FILE=`ls *.$EXT | sort | head -n 1`
  qemu-arm $GEN ./$FILE 
  cd ..
done
-----------------------------------------------------

In order for this to work you need to install the qemu package.



