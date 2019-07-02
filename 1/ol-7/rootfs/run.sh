#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace
# shellcheck disable=SC1091

# Load libraries
. /liblog.sh

readonly cmd=$(command -v notary-signer)
readonly flags=("-config=/etc/notary/signer-config.postgres.json" "-logf=logfmt")
readonly installdir=$(dirname "$(dirname "$cmd")")

cd "$installdir"

info "Running Harbor Notary Server migrations"
"$installdir"/migrations/migrate.sh

info "** Starting Harbor Notary Signer **"
exec "$cmd" "${flags[@]}"
