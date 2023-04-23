#!/bin/sh

STATUS=$(xbps-install -Mun |
	awk '{print $1}' |
	sed 's/$/\\n/' |
	tr -d '\n')
COUNT=$(printf "%b" "$STATUS" | wc -l)

if [ "$COUNT" -gt 0 ]; then
	printf '{"text": "%s", "tooltip": "%s"}\n' "$COUNT" "$STATUS"
else
	printf ''
fi
