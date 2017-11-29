#!/bin/bash

pg_dz_lg() {
    case "$1" in
        no_device_matching) warning "Aucun appareil ne correspond. Ajoutez le dans vos favoris Domoticz, ou declarez un incident si il s'y trouve deja.";;
        switch_on) echo "J'ai allumé $2";;
        switch_off) echo "J'ai éteins $2";;
        blind_on) echo "J'ai fermé $2";;
        blind_off) echo "J'ai ouvert $2";;
		stat) echo "Je regarde... $2:";;
		temp) echo "La temperature $2 est de:";;
        *) error "ERROR: ";;
    esac
}
