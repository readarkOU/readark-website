#!/usr/bin/env bash
# Deploy readark.eu to the Contabo VPS.
#
#   bash scripts/deploy.sh          # ships HEAD
#   bash scripts/deploy.sh <ref>    # ships a branch or commit
#
# Ships `git archive` of the commit (so .gitattributes export-ignore decides what goes:
# no signature page, no README, no deploy files) into /opt/readark/www/site, swapping the
# directory atomically. nginx runs in its own compose project there; Caddy (JuckBox's)
# proxies readark.eu to it. Nothing under /opt/juckbox is touched.
set -euo pipefail

VPS="root@144.91.115.219"
KEY="$HOME/.ssh/juckbox_vps"
DIR=/opt/readark
REF="${1:-HEAD}"
cd "$(dirname "$0")/.."

commit=$(git rev-parse --short "$REF")
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Note: uncommitted changes are not shipped (git archive reads the commit)." >&2
fi

echo "→ config files"
ssh -i "$KEY" "$VPS" "mkdir -p $DIR/www"
scp -q -i "$KEY" deploy/docker-compose.yml deploy/nginx.conf "$VPS:$DIR/"

echo "→ site files: $commit"
git archive --format=tar "$REF" | ssh -i "$KEY" "$VPS" "
  set -e
  rm -rf $DIR/www/site.new && mkdir $DIR/www/site.new && tar -xf - -C $DIR/www/site.new
  echo '$commit' > $DIR/www/site.new/.commit
  rm -rf $DIR/www/site.old
  [ -d $DIR/www/site ] && mv $DIR/www/site $DIR/www/site.old || true
  mv $DIR/www/site.new $DIR/www/site && rm -rf $DIR/www/site.old"

echo "→ container"
ssh -i "$KEY" "$VPS" "cd $DIR && docker compose up -d --quiet-pull 2>&1 | tail -3 && docker exec readark-site nginx -t 2>&1 | tail -1 && docker exec readark-site nginx -s reload"

echo "→ check"
ssh -i "$KEY" "$VPS" "docker exec juckbox-caddy-1 wget -qO- --header='Host: readark.eu' http://readark-site/ | grep -o '<title>[^<]*' | head -1"
echo "✓ deployed $commit"
