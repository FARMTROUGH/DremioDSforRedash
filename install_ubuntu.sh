#!/bin/bash
#
#   Dremio Data Source Driver for Redash
#   Ubuntu Install Script
#
#   Written by Brian K. Holman (bholman@dezota.com)
#
#   This is free and unencumbered software released into the public domain.
#
#   Anyone is free to copy, modify, publish, use, compile, sell, or
#   distribute this software, either in source code form or as a compiled
#   binary, for any purpose, commercial or non-commercial, and by any
#   means.
#
#   In jurisdictions that recognize copyright laws, the author or authors
#   of this software dedicate any and all copyright interest in the
#   software to the public domain. We make this dedication for the benefit
#   of the public at large and to the detriment of our heirs and
#   successors. We intend this dedication to be an overt act of
#   relinquishment in perpetuity of all present and future rights to this
#   software under copyright law.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#   IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
#   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#   OTHER DEALINGS IN THE SOFTWARE.
#
#   For more information, please refer to <http://unlicense.org/>

export REDASH_BASE_PATH=/app
### refresh repos for current package versions
apt-get update && apt-get -y upgrade 
apt-get install -y alien unixodbc unixodbc-dev
wget https://download.dremio.com/odbc-driver/1.4.2.1003/dremio-odbc-1.4.2.1003-1.x86_64.rpm
alien -i --scripts dremio-odbc-1.4.2.1003-1.x86_64.rpm
rm -f dremio-odbc-1.4.2.1003-1.x86_64.rpm
pip install pyodbc pandas dremio_client[full]
wget -O $REDASH_BASE_PATH/redash/query_runner/dremio.py "https://raw.githubusercontent.com/Rodrigonavarro23/redash/tree/dremio-driver/redash/query_runner/dremio.py"
wget -O $REDASH_BASE_PATH/client/dist/images/db-logos/dremio.png "https://raw.githubusercontent.com/FARMTROUGH/DremioDSforRedash/master/dremio_odbc.png"
wget -O $REDASH_BASE_PATH/client/app/assets/images/db-logos/dremio.png "https://raw.githubusercontent.com/FARMTROUGH/DremioDSforRedash/master/dremio_odbc.png"
# Make sure this is the only entry for REDASH_ADDITIONAL_QUERY_RUNNERS.  If you have others then update env manually
echo "export REDASH_ADDITIONAL_QUERY_RUNNERS=redash.query_runner.python,redash.query_runner.dremio_odbc" >> $REDASH_BASE_PATH/.env
