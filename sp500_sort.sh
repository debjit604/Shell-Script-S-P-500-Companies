#!/usr/bin/env bash

CSV_URL="https://raw.githubusercontent.com/datasets/s-and-p-500-companies/refs/heads/main/data/constituents.csv"
OUTPUT_FILE="sp500_companies_sorted_by_year.csv"
TEMP_RAW=$(mktemp)
TEMP_SORTED=$(mktemp)
TEMP_UNKNOWN=$(mktemp)

cleanup() {
    rm -f "$TEMP_RAW" "$TEMP_SORTED" "$TEMP_UNKNOWN"
}
trap cleanup EXIT

echo ""
echo "=============================================="
echo "  S&P 500 COMPANIES - SORTED BY FOUNDING YEAR"
echo "=============================================="
echo ""

echo "Downloading CSV..."
if command -v curl &> /dev/null; then
    curl -sSL --connect-timeout 10 --max-time 30 "$CSV_URL" -o "$TEMP_RAW"
elif command -v wget &> /dev/null; then
    wget -q --timeout=30 "$CSV_URL" -O "$TEMP_RAW"
else
    echo "ERROR: Install curl or wget."
    exit 1
fi

if [ ! -s "$TEMP_RAW" ]; then
    echo "ERROR: Download failed."
    exit 1
fi

echo "Downloaded: $(wc -l < "$TEMP_RAW" | tr -d ' ') lines"
echo ""

echo "Processing and sorting by founding year..."
{
    echo "Company Name|Headquarters Location|Founded Year|Symbol|Sector"
    
    tail -n +2 "$TEMP_RAW" | while IFS=',' read -r symbol name sector sub_sector location date_added cik founded; do
        
        symbol=$(echo "$symbol" | sed 's/^"//;s/"$//' | xargs)
        name=$(echo "$name" | sed 's/^"//;s/"$//' | xargs)
        location=$(echo "$location" | sed 's/^"//;s/"$//' | xargs)
        sector=$(echo "$sector" | sed 's/^"//;s/"$//' | xargs)
        founded=$(echo "$founded" | sed 's/^"//;s/"$//' | xargs)
        
        if [ -z "$founded" ] || ! [[ "$founded" =~ ^[0-9]+$ ]]; then
            echo "0|$name|$location|$symbol|$sector" >> "$TEMP_UNKNOWN"
        else
            printf "%04d|%s|%s|%s|%s\n" "$founded" "$name" "$location" "$symbol" "$sector" >> "$TEMP_SORTED"
        fi
    done
    
    sort -t'|' -k1 -n "$TEMP_SORTED" | while IFS='|' read -r year name location symbol sector; do
        echo "$name|$location|$year|$symbol|$sector"
    done
    
    while IFS='|' read -r _ name location symbol sector; do
        echo "$name|$location|Unknown|$symbol|$sector"
    done < "$TEMP_UNKNOWN"
    
} > "$OUTPUT_FILE"

TOTAL=$(tail -n +2 "$OUTPUT_FILE" | wc -l | tr -d ' ')
KNOWN=$(wc -l < "$TEMP_SORTED" | tr -d ' ')
UNKNOWN=$(wc -l < "$TEMP_UNKNOWN" | tr -d ' ')

echo "Done! Total: $TOTAL | Known year: $KNOWN | Unknown: $UNKNOWN"
echo ""

echo "=============================================="
echo "  TOP 15 OLDEST COMPANIES"
echo "=============================================="
printf "  %-5s %-40s %-25s %s\n" "Year" "Company" "Location" "Symbol"
echo "  ----------------------------------------------------------------"
tail -n +2 "$OUTPUT_FILE" | head -15 | while IFS='|' read -r name location year symbol sector; do
    printf "  %-5s %-40s %-25s %s\n" "$year" "${name:0:39}" "${location:0:24}" "$symbol"
done
echo ""

echo "=============================================="
echo "  TOP 15 NEWEST COMPANIES"
echo "=============================================="
printf "  %-5s %-40s %-25s %s\n" "Year" "Company" "Location" "Symbol"
echo "  ----------------------------------------------------------------"
tail -n +2 "$OUTPUT_FILE" | grep -v "Unknown" | tail -15 | while IFS='|' read -r name location year symbol sector; do
    printf "  %-5s %-40s %-25s %s\n" "$year" "${name:0:39}" "${location:0:24}" "$symbol"
done
echo ""

echo "File saved: $OUTPUT_FILE"
echo "Done."
