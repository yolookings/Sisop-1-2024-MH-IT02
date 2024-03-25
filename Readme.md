# Laporan Resmi Praktikum Sistem Operasi 2024 Modul - 1

### Anggota Kelompok IT 02 :

- Maulana Ahmad Zahiri (5027231010)
- Syela Zeruya Tandi Lalong (5027231076)
- Kharisma Fahrun Nisa' (5027231086)

## Pendahuluan

## Soal 1

### `Deskripsi Pengerjaan`

Pertama, buka terminal linux dan masukkan command chmod +x Sandbox.csv untuk mengatur hak akses file. Selanjutnya kita akan menggunakancommand 'ls' untuk mengecek apakah file Sandbox.csv dan Sandbox.sh sudah tersedia. Jika sudah, selanjutnya kita akan memakai skrip ./Sandbox.sh untuk menjalankan hak akses dari file tersebut.

### `Penjelasan`

```
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0' -O Sandbox.csv
```

command wget digunakan untuk mengunduh file Sandbox.csv, --no-check-certificate: digunakan supaya tidak perlu repot mengecek file sehingga proses mengunduh jadi lebih cepat, -O: Mengontrol nama file dari link yang di download

```
ls
```

untuk menampilkan daftar file dan direktori dalam sebuah direktori atau folder.

```
cat Sandbox.csv
```

menampilkan seluruh isi dari file Sandbox.csv ke layar/terminal.

```
echo BUYER DENGAN SALES TERTINGGI
```

command 'echo' berfungsi untuk menampilkan output ke layar

```
awk -F ',' 'NR > 1 {sales[$6] += $17; if (sales[$6] > highest_sales) highest_sales = sales[$6]} END {for (buyer in sales) if (sales[buyer] == highest_sales) print buyer, sales[buyer]}' Sandbox.csv
```

awk: perintah untuk menjalankan program AWK.

-F ',': menentukan pemisah field sebagai koma (,). Artinya, setiap baris input akan dipecah menjadi field-field yang dipisahkan oleh koma.

'NR > 1 { ... }': pola AWK yang hanya akan memproses baris-baris setelah baris pertama. Dengan kata lain, baris pertama (header) akan diabaikan.

sales[$6] += $17;: Untuk setiap baris yang diproses, kode ini akan menambahkan nilai dari field ke-17 ($17) ke dalam array sales dengan indeks yang sama dengan nilai field ke-6 ($6). Ini berarti nilai-nilai akan diakumulasikan berdasarkan nilai field ke-6.

if (sales[$6] > highest_sales) highest_sales = sales[$6]: Setelah mengakumulasikan nilai, kode ini akan memeriksa apakah nilai yang baru diakumulasikan (sales[$6]) lebih besar dari nilai tertinggi yang ditemukan sebelumnya (highest_sales). Jika iya, maka highest_sales akan diperbarui dengan nilai baru tersebut.

END { ... }: pola AWK yang akan dieksekusi setelah semua baris diproses.

for (buyer in sales) { ... }: Setelah semua baris diproses, kode ini akan melakukan iterasi melalui semua elemen dalam array sales.

if (sales[buyer] == highest_sales) print buyer, sales[buyer]: Untuk setiap elemen dalam array sales, kode ini akan memeriksa apakah nilainya sama dengan highest_sales. Jika iya, maka kode akan mencetak nama pembeli dan nilai akumulasi penjualan tertinggi.

Secara keseluruhan, kode AWK ini akan membaca file CSV, mengakumulasikan nilai penjualan untuk setiap pembeli, mencari nilai penjualan tertinggi, dan mencetak pembeli dengan nilai penjualan tertinggi beserta nilai penjualannya.

```
echo BUYER DENGAN PROFIT TERENDAH
```

'echo' menampilkan output pada layar

```
awk -F ',' 'NR > 1 {profits[$6] += $20; if (profits[$6] < lowest_profit || lowest_profit == "") lowest_profit = profits[$6]} END {for (buyer in profits) if (profits[buyer] == lowest_profit) print buyer, profits[buyer]}' Sandbox.csv
```

-F ',': Opsi ini menyetel pemisah bidang ke koma

NR > 1: Kondisi ini memastikan bahwa skrip hanya memproses baris setelah baris pertama

profits[$6] += $20: Baris ini menambahkan nilai pada kolom ke-20 ke nilai pada kolom ke-6 setiap baris. Hasilnya disimpan dalam array, menggunakan nilai di kolom ke-6 sebagai indeks.profits

if (profits[$6] < lowest_profit || lowest_profit == "") lowest_profit = profits[$6]: Kondisi ini memeriksa apakah nilai saat ini dalam array lebih kecil dari variabel atau kosong. Jika salah satu kondisi benar, nilai saat ini dalam array ditetapkan ke .profitslowest_profitlowest_profitprofitslowest_profit

END {for (buyer in profits) if (profits[buyer] == lowest_profit) print buyer, profits[buyer]}: Blok ini dijalankan di akhir skrip. Command ini akan mengulangi array dan mencetak nama pembeli dan nilai keuntungan yang sesuai jika cocok dengan variabel.profitslowest_profit

Skrip AWK ini memproses file CSV dengan menambahkan nilai di kolom ke-20 ke nilai di kolom ke-6 untuk setiap baris, mencatat nilai keuntungan terendah, lalu mencetak nama pembeli dan nilai keuntungan yang sesuai jika cocok. nilai keuntungan terendah.

```
echo TOP 3 CATEGORIES WITH HIGHEST PROFIT
```

```
cut -d ',' -f 14,20 Sandbox.csv | sort -k20 -nr | head -3
```

Command cut -d ',' -f 14,20 Sandbox.csv mengambil baris dari file CSV Sandbox.csv yang memiliki data pada kolom ke-14 dan ke-20.

sort -k20 -nr mengurutkan data tersebut berdasarkan nilai pada kolom ke-20 dalam urutan negatif (descending order).

head -3 mengambil tiga baris teratas dari data yang telah diurutkan.

Secara keseluruhan, command ini akan mengambil tiga baris dari file CSV Sandbox.csv yang memiliki data pada kolom ke-14 dan ke-20, kemudian mengurutkan data berdasarkan nilai pada kolom ke-20 dalam urutan negatif, dan mengambil tiga baris teratas dari data yang telah diurutkan.

```
echo MENCARI PURCHASE DATE DAN QUANTITY ATAS NAMA ADRIENS
```

```
awk '/Adriaens/ {print}' Sandbox.csv
```

awk '/Adriaens/ {print}' Sandbox.csv akan membaca file Sandbox.csv baris per baris, dan mencetak setiap baris yang mengandung string "Adriaens" ke output standar (layar/terminal).

## Soal 2

## Soal 3

### `Inti Soal`

Soal tersebut menggambarkan tentang seorang gamer bernama Alyss yang ingin mengumpulkan foto-foto karakter dari game Genshin Impact. Dia mendapatkan sebuah link dari temannya, Yanuar, yang berisi kumpulan foto karakter serta sebuah clue yang mengarah pada penemuan gambar rahasia. Setiap nama file dalam link tersebut telah dienkripsi menggunakan hexadecimal. Alyss ingin mendownload file-file tersebut, mendekode nama file yang terenkripsi, dan merename file sesuai dengan data karakter yang terdapat dalam file CSV list_character.csv. Alyss juga ingin mengelompokkan file-file karakter ke dalam folder berdasarkan region karakternya. Selain itu, Alyss ingin menghitung jumlah pengguna untuk setiap senjata yang ada di folder genshin_character.

### `Penyelesaian`

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
