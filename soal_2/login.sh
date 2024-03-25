#!/bin/bash

# deskripsi password dari base64
deskripsi_password() {
  echo "$1" | base64 -d
}

# kecocokan email dan password
check_credentials() {
  local email=$1
  local password=$2
  local stored_password=$(grep "^$email:" users.txt | cut -d: -f5)
  local is_admin=$(grep "^$email:" users.txt | cut -d: -f6)

  # deskripsi password tersimpan
  stored_password_decrypted=$(deskripsi_password "$stored_password")

  if [ "$password" == "$stored_password_decrypted" ]; then
    return 0
  else
    return 1
  fi
}

# lupa password
forgot_password() {
  local email=$1
  local security_question=$(grep "^$email:" users.txt | cut -d: -f3)
  local correct_answer=$(grep "^$email:" users.txt | cut -d: -f4)

  echo "Security Question: $security_question"
  read -p "Enter your answer: " user_answer

  if [ "$user_answer" == "$correct_answer" ]; then
    local stored_password=$(grep "^$email:" users.txt | cut -d: -f5)
    stored_password_decrypted=$(deskripsi_password "$stored_password")
    echo "Your password is: $stored_password_decrypted"
  else
    echo "Incorrect answer."
  fi
}

# Menu admin
admin_menu() {
  local logged_out=false

  while ! $logged_out; do
    echo "Admin Menu"
    echo "1. Add User"
    echo "2. Edit User"
    echo "3. Delete User"
    echo "4. Logout"
    read -p "Choose Menu: " action

    case $action in
    1)
      ./register.sh
      ;;
    2)
      ./edit_user.sh
      ;;
    3)
      ./delete_user.sh
      ;;
    4)
      echo "Logout successful!"
      break
      ;;
    *)
      echo "Invalid action"
      ;;
    esac
  done
}

#Main code

echo "Welcome to Login System"
echo "1. Login"
echo "2. Forgot Password"
read -p "Choose option: " option

case $option in
1)
  read -p "Email: " email
  read -sp "Password: " password
  echo

  # Check if email exists
  grep -q "^$email:" users.txt
  if [ $? -ne 0 ]; then
    echo "[ $(date +'%d/%m/%Y %H:%M:%S') ] [LOGIN FAILED] ERROR: Email $email not found." >>auth.log
    echo "ERROR: Email $email not found."
    exit 1
  fi

  # Validate password
  check_credentials "$email" "$password"
  if [ $? -eq 0 ]; then
    echo "[ $(date +'%d/%m/%Y %H:%M:%S') ] [LOGIN SUCCESS] User with email $email logged in successfully." >>auth.log

    is_admin=$(grep "^$email:" users.txt | cut -d: -f6)
    if [ "$is_admin" == "admin" ]; then
      admin_actions
    else
      echo "Login successful!"
      echo "You don't have admin privileges. Welcome!"
    fi
  else
    echo "[ $(date +'%d/%m/%Y %H:%M:%S') ] [LOGIN FAILED] ERROR: Incorrect password for user with email $email." >>auth.log
    echo "ERROR: Incorrect password."
    read -p "Forgot Password? (y/n): " choice
    if [ "$choice" == "y" ]; then
      forgot_password "$email"
    fi
  fi
  ;;
2)
  read -p "Enter your email: " email
  forgot_password "$email"
  ;;
*)
  echo "Invalid option"
  ;;
esac
