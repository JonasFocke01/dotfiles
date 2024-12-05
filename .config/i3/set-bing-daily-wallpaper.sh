#!/bin/sh

while ! ping -c 1 1.1.1.1 ; do sleep 1 ; done

urlpath=$( \
curl "https://www.bing.com/HPImageArchive.aspx?resolution=UHD&format=rss&idx=0&n=1&mkt=de-de" \
| xmllint --xpath "/rss/channel/item/link/text()" - \
| sed 's/1366x768/1920x1080/g' \
)
curl "https://www.bing.com$urlpath" \
| feh --bg-fill -

