#!/bin/bash

# Fungsi untuk mencatat log
log() {
  echo "[$(date +'%d/%m/%y %H:%M:%S')] [$1] [$2]" >>image.log
}

# Loop untuk memeriksa setiap gambar dalam folder genshin_character
for image_path in genshin_character/*.jpg; do
  log "INFO" "Mengecek $image_path"
  # Ekstrak nilai dari gambar menggunakan steghide
  steghide extract -sf "$image_path" -p "" -xf extracted.txt >/dev/null 2>&1

  # Cek apakah nilai berhasil diekstrak
  if [ -f "extracted.txt" ]; then
    # Baca isi file yang diekstrak
    secret=$(cat extracted.txt)
    # Hapus file teks yang diekstrak
    rm extracted.txt
    # Dekripsi isi teks dari heksadesimal
    decrypted=$(printf "%b" "$secret")
    # Cek apakah isi teks mengandung URL yang dicari
    if [[ $decrypted == *"https://"* ]]; then
      log "FOUND" "$image_path"
      # Unduh file berdasarkan URL
      curl -O "$decrypted"
      exit 0
    else
      log "INFO" "Isi teks: $decrypted"
    fi
  else
    log "NOT FOUND" "$image_path"
  fi
done

rm weapons.txt image.log
rm -rf genshin_character
