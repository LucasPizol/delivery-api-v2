set -o errexit

apt-get update && apt-get install -y libpq-dev

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean