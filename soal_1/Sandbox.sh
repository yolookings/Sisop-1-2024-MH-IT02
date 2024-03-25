Sandbox

# $2: Order Date || $6: Buyer's name || $14: Category || $17: Sales || $20: Profit <-- SECTIONS USED

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0' -O Sandbox.csv

# wget: mengdownload
# --no-check-certificate: Dipakai agar tidak ribet dalam mengecek file :v (takes less time to download, but high in potential risks)
# -O: Mengontrol nama file dari link yang di download

ls

#untuk menampilkan daftar file dan direktori dalam sebuah direktori atau folder.

cat Sandbox.csv
#menampilkan seluruh isi dari file Sandbox.csv ke layar/terminal.

echo BUYER DENGAN SALES TERTINGGI
awk -F ',' 'NR > 1  {sales[$6] += $17; if (sales[$6] > highest_sales) highest_sales = sales[$6]} END {for (buyer in sales) if (sales[buyer] == highest_sales) print buyer, sales[buyer]}' Sandbox.csv

# awk: perintah untuk menjalankan program AWK.
#-F ',': Opsi ini menentukan pemisah field sebagai koma (,). Artinya, setiap baris input akan dipecah menjadi field-field yang dipisahkan oleh koma.
#'NR > 1 { ... }': Blok kode ini akan dieksekusi untuk setiap baris input, kecuali baris pertama. NR adalah variabel built-in AWK yang mewakili nomor baris saat ini.
#sales[$6] += $17;: Baris ini menambahkan nilai dari field ke-17 ($17) ke dalam array sales dengan indeks yang sama dengan nilai field ke-6 ($6). Ini berarti nilai penjualan akan diakumulasikan berdasarkan pembeli (buyer).
#if (sales[$6] > highest_sales) highest_sales = sales[$6]: Baris ini memeriksa apakah nilai penjualan untuk pembeli saat ini (sales[$6]) lebih besar dari nilai highest_sales saat ini. Jika iya, maka highest_sales akan diperbarui dengan nilai penjualan terbesar tersebut.
#END { ... }: Blok kode ini akan dieksekusi setelah semua baris input diproses.
#for (buyer in sales) { ... }: Perulangan ini akan mengiterasi setiap elemen dalam array sales, dengan buyer mewakili indeks (pembeli) dari setiap elemen.
#if (sales[buyer] == highest_sales) print buyer, sales[buyer]: Baris ini akan mencetak nilai buyer (indeks array) dan nilai penjualan (sales[buyer]) jika nilai penjualan tersebut sama dengan nilai highest_sales.
#Secara keseluruhan, kode AWK ini akan membaca file CSV, mengakumulasikan nilai penjualan untuk setiap pembeli, mencari nilai penjualan tertinggi, dan mencetak pembeli dengan nilai penjualan tertinggi beserta nilai penjualannya.

echo BUYER DENGAN PROFIT TERENDAH
awk -F ',' 'NR > 1 {profits[$6] += $20; if (profits[$6] < lowest_profit || lowest_profit == "") lowest_profit = profits[$6]} END {for (buyer in profits) if (profits[buyer] == lowest_profit) print buyer, profits[buyer]}' Sandbox.csv
# profits[$6] += $20;: Baris ini menambahkan nilai dari field ke-20 ($20) ke dalam array profits dengan indeks yang sama dengan nilai field ke-6 ($6). Ini berarti nilai-nilai akan diakumulasikan berdasarkan nilai field ke-6.
#if (profits[$6] < lowest_profit || lowest_profit == ""): Kondisi ini memeriksa apakah nilai yang baru saja diakumulasikan (profits[$6]) lebih kecil dari nilai lowest_profit saat ini, atau jika lowest_profit belum diinisialisasi (kosong).
#lowest_profit = profits[$6]: Jika kondisi di atas terpenuhi, maka nilai lowest_profit akan diperbarui dengan nilai profits[$6].
#END {...}: Blok kode ini akan dieksekusi setelah semua baris input selesai diproses.
#for (buyer in profits): Perulangan ini akan mengiterasi setiap elemen dalam array profits.
#if (profits[buyer] == lowest_profit): Kondisi ini memeriksa apakah nilai profits[buyer] (nilai akumulasi untuk buyer tertentu) sama dengan lowest_profit.
#print buyer, profits[buyer]: Jika kondisi di atas terpenuhi, maka program akan mencetak nilai buyer dan profits[buyer] (nilai akumulasi terendah).

echo TOP 3 CATEGORIES WITH HIGHEST PROFIT
cut -d ',' -f 14,20 Sandbox.csv | sort -k20 -nr | head -3
#cut -d ',' -f 14,20 Sandbox.csv is used to extract specific columns from a CSV file named "Sandbox.csv" using the delimiter ','. The -d option specifies the delimiter, and the -f option specifies the fields to be extracted. In this case, fields 14 and 20 are extracted.
#sort -k20 -nr sorts the output of the previous command based on the 20th field in reverse numerical order. The -k option specifies the field to be sorted, and the -n option sorts the data numerically. The -r option sorts the data in reverse order.
#head -3 is used to display the first three lines of the sorted output. The -3 option specifies the number of lines to be displayed.

echo MENCARI PURCHASE DATE DAN QUANTITY ATAS NAMA ADRIENS
awk '/Adriaens/ {print}' Sandbox.csv
# awk '/Adriaens/ {print}' Sandbox.csv akan membaca file Sandbox.csv baris per baris, dan mencetak setiap baris yang mengandung string "Adriaens" ke output standar (layar/terminal).
