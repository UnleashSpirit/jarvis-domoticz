#!/bin/bash
pg_dz_lg() {
    case "$1" in
        no_device_matching) warning "Aucun appareil ne correspond. Ajoutez le dans vos favoris Domoticz, ou declarez un incident si il s'y trouve deja.";;
        switch_on) echo "I switched on $2";;
        switch_off) echo "I switched off $2";;
        blind_on) echo "I've closed $2";;
        blind_off) echo "I've opened $2";;
		stat) echo "Wait... $2:";;
		temp) echo "Temperature of $2:";;
        *) error "ERROR: ";;
    esac
}
