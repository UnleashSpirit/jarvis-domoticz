#!/bin/bash

pg_dz_idx () {
local pg_dz_device="$(curl -s "http://${pg_dz_domoticz_ip}:${pg_dz_domoticz_port}/json.htm?type=devices&used=true&filter=all&favorite=1")"

local -r order="$(sanitize "$order")"
    while read device; do
        local sdevice="$(sanitize "$device" ".*")"
		if [[ "$order" =~ .*$sdevice.* ]]; then
            local idx="$(echo $pg_dz_device | jq -r ".result[] | select(.Name==\"$device\") | .idx")"
			return $idx
        fi
    done <<< "$(echo $pg_dz_device | jq -r '.result[].Name')"
    say "$(pg_dz_lg "no_device_matching")"
    return 0

}

pg_dz_switch () {
local api="http://${pg_dz_domoticz_ip}:${pg_dz_domoticz_port}/json.htm?${pg_dz_api_switch}${1}"
pg_dz_idx $2
local idx=$?
if [ $idx != 0 ]; then
curl "${api}&idx=${idx}"
say "$(pg_dz_lg "switch_$1" "$device")"
else
return 0
fi
}


pg_dz_stat () {
local api="http://${pg_dz_domoticz_ip}:${pg_dz_domoticz_port}/json.htm?${pg_dz_api_temp}"
pg_dz_idx $1
local idx=$?
if [ $idx != 0 ]; then
local curl="$(curl -s "${api}&rid=${idx}" | jq -r '.result[0].Data' | sed "s/C/degrés/g" | sed "s/%/% dhumidité/g")"
say "$(pg_dz_lg "stat" "$device") $curl"
else
return 0
fi
}

pg_dz_blind () {
local api="http://${pg_dz_domoticz_ip}:${pg_dz_domoticz_port}/json.htm?${pg_dz_api_switch}${1}"
pg_dz_idx $2
local idx=$?
if [ $idx != 0 ]; then
curl "${api}&idx=${idx}"
say "$(pg_dz_lg "blind_$1" "$device")"
else
return 0
fi
}

pg_dz_temp () {
local api="http://${pg_dz_domoticz_ip}:${pg_dz_domoticz_port}/json.htm?${pg_dz_api_temp}"
pg_dz_idx $1
local idx=$?
if [ $idx != 0 ]; then
local curl="$(curl -s "${api}&rid=${idx}" | jq -r '.result[0].Data' | sed "s/C/degrés/g" | sed "s/%/% dhumidité/g")"
say "$(pg_dz_lg "temp" "$device") $curl"
else
return 0
fi
}