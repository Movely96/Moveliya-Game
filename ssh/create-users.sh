#!/bin/bash
# Creates the three lab accounts, their home content, and the hidden files
# holding the web-portal credentials. Shared by the Docker image build and
# by vm-setup/setup.sh, so there is one source of truth for the answers.
# Run as root (Docker) or via sudo (VM).
set -e

create_user () {
    local name="$1" pass="$2"
    id "$name" >/dev/null 2>&1 || useradd -m -s /bin/bash "$name"
    echo "$name:$pass" | chpasswd
    chmod 700 "/home/$name"   # other lab users must not read each other's files
}

# Values are stored encoded so they do not show up in a quick read/grep of the repo.
dec () { printf '%s' "$1" | base64 -d; }

# ---- Accounts ----
create_user nassit "$(dec TmFzc2l0MTk3Mw==)"
create_user mehdi  "$(dec TGlsbTE5ODA=)"
create_user jannat "$(dec TWltaTIwMTg=)"

# ---- Home folders (flavor + a couple of decoy files) ----
su - nassit -c 'mkdir -p ~/Pictures ~/Documents; touch ~/Pictures/family_photo.jpg ~/Pictures/graduation_1996.jpg ~/Pictures/barcelona_match.jpg; echo "Meeting with FSTBM alumni association next week." > ~/Documents/notes.txt'
su - mehdi  -c 'mkdir -p ~/Pictures ~/Documents; touch ~/Pictures/lilm_dog.jpg ~/Pictures/car_restoration_1.jpg ~/Pictures/car_restoration_2.jpg; echo "Structural mechanics course - review chapter 4." > ~/Documents/course_notes.txt'
su - jannat -c 'mkdir -p ~/Pictures ~/Documents; touch ~/Pictures/mimi_cat.jpg ~/Pictures/tetouan_beach.jpg ~/Pictures/tetouan_medina.jpg; echo "Print exam papers - deadline Friday." > ~/Documents/todo.txt'

# ---- Hidden files with web-portal credentials ----
plant_portal () {
    local name="$1" portal_user="$2" portal_pass="$3"
    su - "$name" -c "mkdir -p ~/.hidden && cat > ~/.hidden/portal_access.txt" <<EOF
GCE Staff Portal - Access Notes

uni-web login:
username: $portal_user
password: $portal_pass
EOF
}

plant_portal nassit abdelmajid.nassit "$(dec VnNCWXpXQlB0SGlPdDI=)"
plant_portal mehdi  mehdi.medali      "$(dec YnZvZnNrYU9EYUZpM1c=)"
plant_portal jannat jannat.lmilali    "$(dec Nk9tdjBhMlpqQ0pldHc=)"

echo "[*] Accounts and hidden portal files created."
