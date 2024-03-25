#!/bin/bash

# mengenkripsi password menggunakan base64
enkripsi_password() {
  echo -n "$1" | base64
}

# memeriksa apakah email sudah terdaftar
check_email() {
  local email=$1
  grep -q "^$email:" users.txt
  return $?
}

# untuk mendaftarkan pengguna baru
register_user() {
  local email=$1
  local username=$2
  local security_question=$3
  local security_answer=$4
  local password=$5
  local user_type="user" # Tipe pengguna default

  # untuk memeriksa apakah ada kata admin di dalam email dan menetapkan flag admin
  if [[ "$email" == *admin* ]]; then
    user_type="admin"
  fi

  # enkripsi password
  encrypted_password=$(enkripsi_password "$password")

  # memeriksa email
  check_email "$email"
  if [ $? -eq 0 ]; then
    echo "[ $(date +'%d/%m/%Y %H:%M:%S') ] [REGISTER FAILED] Email $email already registered." >>auth.log
    echo "Email $email already registered. Please choose another email."
    exit 1
  fi

  # memasukkan data pengguna ke dalam users.txt dengan flag admin
  echo "$email:$username:$security_question:$security_answer:$encrypted_password:$user_type" >>users.txt

  if [[ $user_type == "admin" ]]; then
    echo "[ $(date +'%d/%m/%Y %H:%M:%S') ] [REGISTER SUCCESS] Admin $username registered succesfully." >>auth.log
    echo "Admin $username registered successfully."
  else
    echo "[ $(date +'%d/%m/%Y %H:%M:%S') ] [REGISTER SUCCESS] User $username registered successfully." >>auth.log
    echo "User $username registered successfully."
  fi
}

# Main code

# untuk membuat users.txt jika belum ada
touch users.txt

echo "Welcome to Registration System"
read -p "Enter your email: " email
read -p "Enter your username: " username
read -p "Enter a security question: " security_question
read -p "Enter the answer to your security question: " security_answer
read -sp "Enter a password (minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same as username, birthdate, or name): " password
echo

# untuk validasi password
while true; do
  if [[ ${#password} -lt 8 || !("$password" =~ [[:lower:]]) || !("$password" =~ [[:upper:]]) || !("$password" =~ [0-9]) ]]; then
    echo "Password must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, and 1 digit."
    read -sp "Enter a password (minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same as username, birthdate, or name):  " password
    echo
  else
    break
  fi
done

register_user "$email" "$username" "$security_question" "$security_answer" "$password"
