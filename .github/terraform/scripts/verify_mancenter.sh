#!/bin/bash

set -e

EXPECTED_SIZE=$1

verify_hazelcast_cluster_size() {
    EXPECTED_SIZE=$1
    for i in `seq 1 5`; do
        local MEMBER_COUNT=$(cat ~/logs/mancenter.stdout.log | grep -E " Started communication with (a new )?member" | wc -l) 

        if [ "$MEMBER_COUNT" == "$EXPECTED_SIZE" ] ; then
            echo "Hazelcast cluster size equal to ${EXPECTED_SIZE}"
            return 0
        else
            echo "Hazelcast cluster size NOT equal to ${EXPECTED_SIZE}!. Waiting.."
            sleep 5
        fi
    done
    return 1
}

echo "Verifying the Hazelcast cluster connected to Management Center"
verify_hazelcast_cluster_size $EXPECTED_SIZE