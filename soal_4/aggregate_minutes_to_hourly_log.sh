#!/bin/bash

# Menentukan waktu saat ini
timestamp=$(date +"%Y%m%d%H")

# Mendapatkan daftar file log dalam satu jam terakhir
files=$(ls /home/$vboxuser/log/metrics_*${timestamp}*.log)

# Inisialisasi variabel untuk menyimpan nilai minimum, maksimum, dan rata-rata
mem_total_min=0
mem_total_max=0
mem_total_avg=0
# ... (ulangi untuk semua variabel)

# Menghitung nilai minimum, maksimum, dan rata-rata untuk setiap metrik
for file in $files; do
  mem_total=$(awk '{print $1}' $file)
  # ... (ulangi untuk semua variabel)

  if [[ $mem_total -lt $mem_total_min ]]; then
    mem_total_min=$mem_total
  fi

  if [[ $mem_total -gt $mem_total_max ]]; then
    mem_total_max=$mem_total
  fi

  mem_total_avg=$((mem_total_avg + mem_total))
done

# Menghitung rata-rata
mem_total_avg=$((mem_total_avg / ${#files}))
# ... (ulangi untuk semua variabel)

# Menulis informasi agregasi ke file log
echo "minimum,$mem_total_min,$mem_used_min,$mem_free_min,$mem_shared_min,$mem_buff_min,$mem_available_min,$swap_total_min,$swap_used_min,$swap_free_min,$path,$path_size_min" >>/home/$vboxuser/log/metrics_agg_$timestamp.log
echo "maximum,$mem_total_max,$mem_used_max,$mem_free_max,$mem_shared_max,$mem_buff_max,$mem_available_max,$swap_total_max,$swap_used_max,$swap_free_max,$path,$path_size_max" >>/home/$vboxuser/log/metrics_agg_$timestamp.log
echo "average,$mem_total_avg,$mem_used_avg,$mem_free_avg,$mem_shared_avg,$mem_buff_avg,$mem_available_avg,$swap_total_avg,$swap_used_avg,$swap_free_avg,$path,$path_size_avg" >>/home/$vboxuser/log/metrics_agg_$timestamp.log
