#!/bin/sh

cmd="excelVueI18n -p assets/translations/tablets_localization.xlsx -f assets/translations"
echo "Execute: $cmd"
eval "$cmd"
