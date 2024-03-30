#!/bin/bash
# Download file zip
CSV_URL='https://drive.usercontent.google.com/u/0/uc?id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN&export=download'
curl -L -o genshin.zip "$CSV_URL"

unzip genshin.zip

unzip genshin_character.zip

# Fungsi untuk mendapatkan nama karakter dari file CSV
get_character_name() {
  while IFS=, read -r nama region element senjata; do
    if [[ "$1" == "$nama" ]]; then
      echo "$region - $nama - $element - $senjata"
      return
    fi
  done <list_character.csv
}

# Memproses setiap file dalam folder genshin_character
for file_path in genshin_character/*; do
  if [ -f "$file_path" ]; then
    # Mendapatkan nama file tanpa path
    file_name=$(basename "$file_path")

    # Print debug info
    echo "Processing file: $file_name"

    # Mendekode nama file dari hexadecimal
    nama_karakter=$(echo "$file_name" | xxd -r -p)

    # Print debug info
    echo "Decoded character name: $nama_karakter"

    # Mendapatkan nama karakter dari nama file yang telah didekode
    character_name=$(get_character_name "$nama_karakter")

    if [ -n "$character_name" ]; then
      # Membuat nama baru
      new_name="$character_name.jpg"

      # Mendapatkan region dari nama karakter
      region=$(echo "$character_name" | cut -d' ' -f1)

      # Menyiapkan path folder region
      region_folder="genshin_character/$region"

      # Membuat folder region jika belum ada
      mkdir -p "$region_folder"

      # Menyiapkan path file baru
      new_path="$region_folder/$new_name"

      # Merubah nama file dan memindahkannya ke folder region
      mv "$file_path" "$new_path"
      echo "File $file_name berhasil direname dan dipindahkan ke $region_folder."
    else
      echo "Tidak dapat menemukan informasi karakter untuk file $file_name."
    fi
  fi
done

echo "Menghitung jumlah pengguna untuk setiap senjata..."
# Mendapatkan senjata dari setiap file karakter dan menyimpannya ke file sementara
for file_path in genshin_character/*/*.jpg; do
  weapon=$(basename "$file_path" | cut -d' ' -f4)
  echo "$weapon"
done >>weapons.txt

# Menghitung jumlah pengguna untuk setiap senjata dari file CSV dan menampilkan hasilnya
# grep bertujuan meghilangkan filter senjata
cut -d',' -f4 'list_character.csv' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | grep -v "Senjata" | sort | uniq -c | awk '{print $2 " : " $1}'

rm genshin_character.zip genshin.zip list_character.csv
