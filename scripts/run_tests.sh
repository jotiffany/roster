#!/bin/bash
# Run cupcake tests

usage()
{
cat << EOF
usage: $0 options

This script will run the test suites for cupcake.

OPTIONS:
   -h     Show this message
   -a     Run all the tests
   -s     Run rspec tests
   -r     Run rubocop tests
   -l     Run haml-lint tests
   -c     Will open the code coverage page
   -v     Verbose
EOF
}

log()
{
  if [[ $VERBOSE -eq 1 ]]; then
    echo $@
  fi
}

display_coverage()
{
  open coverage/index.html
}

do_rspec()
{
  log 'Running Rspec...'
  rspec
  log 'Done Rspec'
  [ $OPEN_COVERAGE -eq 1 ] && display_coverage
}

do_rubocop()
{
  log 'Running Rubocop...'
  rubocop --auto-correct
  git status -sb
  log 'Done Rubocop'
}

do_haml_lint()
{
  log 'Running Haml Lint...'
  haml-lint app/views
  log 'Done Haml Lint'
}

display_coverage()
{
  open coverage/index.html
}

run_all(){
  [ $RUN_RSPEC -eq 1 ] && do_rspec
  [ $RUN_RUBOCOP -eq 1 ] && do_rubocop
  [ $RUN_HAML_LINT -eq 1 ] && do_haml_lint
}

RUN_RSPEC=0
RUN_RUBOCOP=0
RUN_HAML_LINT=0
OPEN_COVERAGE=0
VERBOSE=0

while getopts “hasrlcv” OPTION
do
   case $OPTION in
    h)
      usage
      exit 1
      ;;
    a)
      RUN_RSPEC=1
      RUN_RUBOCOP=1
      RUN_HAML_LINT=1
      OPEN_COVERAGE=1
      run_all
      exit 1
      ;;
    s)
      RUN_RSPEC=1
      ;;
    r)
      RUN_RUBOCOP=1
      ;;
    l)
      RUN_HAML_LINT=1
      ;;
    c)
      OPEN_COVERAGE=1
      ;;
    v)
      VERBOSE=1
      ;;
    ?)
      usage
      exit
      ;;
   esac
done

run_all