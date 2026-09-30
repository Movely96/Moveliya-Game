#!/bin/bash
# Creates the three lab accounts, their home content, and the hidden files
# holding the web-portal credentials. Shared by the Docker image build and
# by vm-setup/setup.sh, so there is one source of truth for the answers.
# Run as root (Docker) or via sudo (VM).
set -e

create_user () {
    local name="$1" pass="$2"
    useradd -m -s /bin/bash "$name" 2>/dev/null || true
    echo "$name:$pass" | chpasswd
}

# ---- Accounts (SSH passwords are OSINT-derivable) ----
create_user nassit Nassit1973
create_user mehdi  Lilm1980
create_user jannat Mimi2018

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

plant_portal nassit abdelmajid.nassit Bagzhgu4yft7
plant_portal mehdi  mehdi.medali      Dh5fbueR4mQA
plant_portal jannat jannat.lmilali    Kx8pQ2vNzL7m

echo "[*] Accounts and hidden portal files created."
