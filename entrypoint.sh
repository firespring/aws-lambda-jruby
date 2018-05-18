#!/bin/bash
set -eou pipefail

cd /usr/src/app/

# This is here so we can pass a command to run w/o having to override the entrypoint
if [ ! -z "${@}" ]
then
  echo "Running [ $@ ]"
  exec $@
  exit
fi

die()
{
  echo
  echo >&2 "$@"
  exit 2
}

# Ensure the volumes paths are present
[ -f "/usr/src/code/Gemfile" ] || die "Source code Gemfile not found! (in /usr/src/code)"
[ -f "/usr/src/code/main.rb" ] || die "Source code main.rb not found! (in /usr/src/code)"

# Copy the source code into the container from the linked volume
cp -r /usr/src/code/* /usr/src/app/src/main/resources/

# Run bundle install for the project
cd /usr/src/app/src/main/resources/
jruby -S bundle install --path=vendor --without test development

# Build the project
cd /usr/src/app/
./gradlew build

# Copy the distribution back into the code directory
cp /usr/src/app/build/distributions/app.zip /usr/src/code/app.zip
