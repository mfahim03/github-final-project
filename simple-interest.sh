#!/usr/bin/env bash

set -euo pipefail

read -r -p "Enter the principal amount: " principal
read -r -p "Enter the annual rate of interest (%): " rate
read -r -p "Enter the time period (years): " time

if ! awk -v p="$principal" -v r="$rate" -v t="$time" 'BEGIN {
  if (p !~ /^[0-9]+([.][0-9]+)?$/ || r !~ /^[0-9]+([.][0-9]+)?$/ || t !~ /^[0-9]+([.][0-9]+)?$/) exit 1
}'; then
  printf '%s\n' "Please enter non-negative numbers for principal, rate, and time." >&2
  exit 1
fi

awk -v p="$principal" -v r="$rate" -v t="$time" 'BEGIN {
  interest = p * r * t / 100
  total = p + interest
  printf "Simple interest: %.2f\nTotal amount: %.2f\n", interest, total
}'
