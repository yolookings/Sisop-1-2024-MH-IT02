# Laporan Resmi Praktikum Sistem Operasi 2024 Modul - 1

### Anggota Kelompok IT 02 :

- Maulana Ahmad Zahiri (5027231010)
- Syela Zeruya Tandi Lalong (5027231076)
- Kharisma Fahrun Nisa' (5027231086)

## Pendahuluan

## Soal 1

## Soal 2

## Soal 3

### Inti Soal

Soal tersebut menggambarkan tentang seorang gamer bernama Alyss yang ingin mengumpulkan foto-foto karakter dari game Genshin Impact. Dia mendapatkan sebuah link dari temannya, Yanuar, yang berisi kumpulan foto karakter serta sebuah clue yang mengarah pada penemuan gambar rahasia. Setiap nama file dalam link tersebut telah dienkripsi menggunakan hexadecimal. Alyss ingin mendownload file-file tersebut, mendekode nama file yang terenkripsi, dan merename file sesuai dengan data karakter yang terdapat dalam file CSV list_character.csv. Alyss juga ingin mengelompokkan file-file karakter ke dalam folder berdasarkan region karakternya. Selain itu, Alyss ingin menghitung jumlah pengguna untuk setiap senjata yang ada di folder genshin_character.

### Penyelesaian

```
#!/bin/bash:
```

Ini adalah shebang line yang memberi tahu sistem operasi bahwa script ini adalah script bash dan harus dijalankan menggunakan bash shell.

```
CSV_URL='https://drive.usercontent.google.com/u/0/uc?id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN&export=download'
```

Ini adalah variabel yang berisi URL dari file zip yang akan diunduh.

```
curl -L -o genshin.zip "$CSV_URL"
```

Ini adalah perintah untuk mengunduh file zip dari URL yang disimpan dalam variabel CSV_URL dan menyimpannya dengan nama genshin.zip. -L digunakan untuk mengikuti redirect jika ada, dan -o digunakan untuk menentukan nama file output.

```
unzip genshin.zip
```

Ini adalah perintah untuk mengekstrak isi dari file zip yang telah diunduh.

```
unzip genshin_character.zip
```

Ini adalah perintah untuk mengekstrak isi dari file zip genshin_character.zip.

```
get_character_name() { ... }
```

Ini adalah definisi fungsi Bash yang bernama get_character_name. Fungsi ini membaca file CSV list_character.csv dan mencocokkan nama karakter yang diberikan dengan baris yang sesuai dalam file CSV untuk mendapatkan informasi karakter tersebut.

```
for file_path in genshin_character/\*; do ... done
```

Ini adalah loop yang akan melakukan iterasi pada setiap file dalam folder genshin_character.

```
if [ -f "$file_path" ]; then ... fi
```

Ini adalah kondisional yang memeriksa apakah file yang sedang diproses adalah file regular atau bukan.

```
file_name=$(basename "$file_path")
```

Ini adalah perintah untuk mendapatkan nama file dari path lengkap file tersebut.

```
nama_karakter=$(echo "$file_name" | xxd -r -p)
```

Ini adalah perintah untuk mendekode nama karakter dari representasi hexadecimal menggunakan perintah xxd.

```
character_name=$(get_character_name "$nama_karakter")
```

Ini adalah pemanggilan fungsi get_character_name untuk mendapatkan informasi karakter berdasarkan nama karakter yang sudah didekode.

```
if [ -n "$character_name" ]; then ... fi
```

Ini adalah kondisional untuk memeriksa apakah informasi karakter ditemukan atau tidak.

```
new_name="$character_name.jpg"
```

Ini adalah perintah untuk membuat nama baru untuk file karakter dengan menambahkan ekstensi .jpg.

```
region=$(echo "$character_name" | cut -d' ' -f1)
```

Ini adalah perintah untuk mendapatkan region karakter dari nama karakter yang sudah didekode.

```
mkdir -p "$region_folder"
```

Ini adalah perintah untuk membuat folder berdasarkan region karakter jika belum ada.

```
mv "$file_path" "$new_path"
```

Ini adalah perintah untuk merename dan memindahkan file karakter ke folder yang sesuai.

```
for file*path in genshin_character/*/\_.jpg; do ... done
```

Ini adalah loop yang akan melakukan iterasi pada setiap file gambar karakter di dalam subfolder genshin_character.

```
weapon=$(basename "$file_path" | cut -d' ' -f4)
```

Ini adalah perintah untuk mendapatkan nama senjata dari nama file gambar karakter.

```
echo "$weapon" >>weapons.txt
```

Ini adalah perintah untuk menambahkan nama senjata ke dalam file weapons.txt.

```
awk -F ',' 'NR > 1 {print $4}' 'list_character.csv' | sort | uniq -c
```

menggunakan perintah awk untuk mengambil nama senjata dari file list_character.csv, mengurutkannya, dan menghitung jumlah kemunculannya.

```
rm list_character.csv genshin.zip genshin_character.zip weapons.txt
rm -rf genshin_character
```

menggunakan perintah rm untuk menghapus file yang tidak diperlukan, yaitu list_character.csv, genshin.zip, genshin_character.zip, weapons.txt, dan direktori genshin_character.

## Soal 4

```

```
