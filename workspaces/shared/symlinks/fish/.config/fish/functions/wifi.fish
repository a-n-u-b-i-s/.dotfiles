function wifi-password
    security find-generic-password -wa (wifi-network-name)
end

function wifi-network-name
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'
end
