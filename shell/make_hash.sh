#!/bin/sh

if [[ "$1" != "sha1" ]] && [[ "$1" != "sha256" ]] && [[ "$1" != "sha512" ]] && [[ "$1" != "md5" ]]; then
  echo Unknown algorithm \"${1}\""!"
  exit
fi

function hash_file(){
  if [[ "${2##*.}" == "sha1" ]] || [[ "${2##*.}" == "sha256" ]] || [[ "${2##*.}" == "sha512" ]] || [[ "${2##*.}" == "md5" ]]; then
    return
  fi
  if [ ! -f "$2.$1" ]; then
    sum=$(set -- $(${1}"sum" "$2"); echo $1)
    echo $sum $(basename "$2")
    echo $sum $(basename "$2") > "$2.$1"
  fi
}

function hash_dir(){
  for item in $2/*
  do
    $0 $1 "$item"
  done
}

if [ -f "$2" ]; then
  hash_file "$1" "$2"
fi

if [ -d "$2" ]; then
  hash_dir "$1" "$2"
fi
