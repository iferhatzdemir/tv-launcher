#!/bin/bash
# Ana ekranı Samsung monitöre kurar: bağlanır, paketler, imzalar, yükler ve başlatır.
# Kullanım:  ./kur.sh [monitör-ip] [sertifika-profili]   örnek: ./kur.sh 192.168.1.6
#            ./kur.sh 192.168.1.6 --duid                monitörün cihaz kimliğini (DUID) yazar
set -euo pipefail

IP="${1:-192.168.1.6}"
ARG="${2:-samsung-m5}"
T="$HOME/tizen-studio/tools"
TIZEN="$T/ide/bin/tizen"
DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD="$DIR/build"
SERIAL="$IP:26101"

echo "→ Monitöre bağlanılıyor ($SERIAL)…"
"$T/sdb" connect "$SERIAL" >/dev/null 2>&1 || true
if ! "$T/sdb" devices | grep -q "^$SERIAL"; then
  echo "✗ Bağlanılamadı. Monitörde Geliştirici Modu açık mı ve Ana bilgisayar IP'si bu Mac'in IP'si"
  echo "  ($(ipconfig getifaddr en0 2>/dev/null || echo '?')) mi? Ayardan sonra monitörü fişten çekip açmayı unutma."
  exit 1
fi

if [ "$ARG" = "--duid" ]; then
  "$T/sdb" -s "$SERIAL" capability | grep -i -E "duid|platform_version"
  exit 0
fi

PROFILE="$ARG"
if ! "$TIZEN" security-profiles list 2>/dev/null | grep -q -w -- "$PROFILE"; then
  echo "✗ '$PROFILE' adlı sertifika profili yok. Certificate Manager'da bu adla Samsung sertifikası oluştur"
  echo "  (KURULUM.md → Seçenek B)."
  exit 1
fi

echo "→ Paket hazırlanıyor…"
rm -rf "${BUILD:?}"
mkdir -p "$BUILD"
cp "$DIR/config.xml" "$DIR/icon.png" "$BUILD/"
cp "$DIR/../index.html" "$BUILD/"
"$TIZEN" package -t wgt -s "$PROFILE" -- "$BUILD" >/dev/null
WGT="$(find "$BUILD" -maxdepth 1 -name '*.wgt' | head -1)"
mv "$WGT" "$BUILD/AnaEkran.wgt"   # dosya adında boşluk olursa kurulum başarısız oluyor

echo "→ Monitöre yükleniyor…"
"$TIZEN" install -n AnaEkran.wgt -s "$SERIAL" -- "$BUILD"
echo "→ Başlatılıyor…"
"$TIZEN" run -p AnaEkranTV.Home -s "$SERIAL"
echo "✓ Tamam. Monitörde Uygulamalar'da 'Ana Ekran' adıyla duruyor."
