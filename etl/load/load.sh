#!/bin/bash
set -e

export WORKING_DIR=/Users/jjardel/dev/distractingdonald # Todo: initialize someplace else

. $WORKING_DIR/initialize_environment_vars.sh
cd $WORKING_DIR/etl/load

$WORKING_DIR/lib/utils/bin/psqlwrapper.sh $WORKING_DIR/etl/transform/schema_setup.sql

# load events
echo "loading events data"
./load_events.sh

# load tweets
echo "loading tweets data"
python load_data.py --config $WORKING_DIR/config/db_creds_local.json \
                    --file $WORKING_DIR/etl/data/tweets.csv \
                    --table tweets \
                    --schema raw