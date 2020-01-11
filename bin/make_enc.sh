#!/bin/bash

CIPHER=-aes-256-cbc
KEY_DERIV=-pbkdf2

if [ "-tar" == $1 ]; then
	USE_TAR=true
	IN_FILE=$2
	OUT_FILE=$IN_FILE.tar.sh
else
	IN_FILE=$1
	OUT_FILE=$IN_FILE.sh
fi

echo '#!/bin/bash' > $OUT_FILE 

if [ "$USE_TAR" == "true" ]; then
	echo "openssl enc -d -a -bf $CIPHER $KEY_DERIV << _END_ | tar xvJ " >> $OUT_FILE
	tar cvJ $IN_FILE | openssl enc -a $CIPHER $KEY_DERIV >> $OUT_FILE
else
	echo "openssl enc -d -a -bf $CIPHER $KEY_DERIV << _END_ | xzcat" >> $OUT_FILE
	xz < $IN_FILE | openssl enc -a $CIPHER $KEY_DERIV >> $OUT_FILE
fi

echo '_END_' >> $OUT_FILE

chmod a+x $OUT_FILE
