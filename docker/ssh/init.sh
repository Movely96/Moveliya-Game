#!/bin/bash
# Recreates the three lab accounts, their home-directory contents, and the
# hidden portal-credential files - the same layout the original vm-setup/setup.sh
# built inside a VM. Runs once at container start, then hands off to sshd.
set -e

create_user() {
    local user="$1" pass="$2"
    if ! id "$user" >/dev/null 2>&1; then
        useradd -m -s /bin/bash "$user"
    fi
    echo "$user:$pass" | chpasswd
}

# ---- Accounts (weak passwords, solvable from the OSINT dossiers) ----
create_user nassit Nassit1973
create_user mehdi  Lilm1980
create_user jannat Mimi2018

# ---- Home directory decoy content ----
sudo -u nassit mkdir -p /home/nassit/Pictures /home/nassit/Documents
sudo -u nassit touch /home/nassit/Pictures/family_photo.jpg
sudo -u nassit touch /home/nassit/Pictures/graduation_1996.jpg
sudo -u nassit touch /home/nassit/Pictures/barcelona_match.jpg
echo "Meeting with FSTBM alumni association next week." | sudo -u nassit tee /home/nassit/Documents/notes.txt > /dev/null

sudo -u mehdi mkdir -p /home/mehdi/Pictures /home/mehdi/Documents
sudo -u mehdi touch /home/mehdi/Pictures/lilm_dog.jpg
sudo -u mehdi touch /home/mehdi/Pictures/car_restoration_1.jpg
sudo -u mehdi touch /home/mehdi/Pictures/car_restoration_2.jpg
echo "Structural mechanics course - review chapter 4." | sudo -u mehdi tee /home/mehdi/Documents/course_notes.txt > /dev/null

sudo -u jannat mkdir -p /home/jannat/Pictures /home/jannat/Documents
sudo -u jannat touch /home/jannat/Pictures/mimi_cat.jpg
sudo -u jannat touch /home/jannat/Pictures/tetouan_beach.jpg
sudo -u jannat touch /home/jannat/Pictures/tetouan_medina.jpg
echo "Print exam papers - deadline Friday." | sudo -u jannat tee /home/jannat/Documents/todo.txt > /dev/null

# ---- Hidden files with web-portal credentials ----
sudo -u nassit mkdir -p /home/nassit/.hidden
cat <<'EOF' | sudo -u nassit tee /home/nassit/.hidden/portal_access.txt > /dev/null
GCE Staff Portal - Access Notes

uni-web login:
username: abdelmajid.nassit
password: Bagzhgu4yft7
EOF

sudo -u mehdi mkdir -p /home/mehdi/.hidden
cat <<'EOF' | sudo -u mehdi tee /home/mehdi/.hidden/portal_access.txt > /dev/null
GCE Staff Portal - Access Notes

uni-web login:
username: mehdi.medali
password: Dh5fbueR4mQA
EOF

sudo -u jannat mkdir -p /home/jannat/.hidden
cat <<'EOF' | sudo -u jannat tee /home/jannat/.hidden/portal_access.txt > /dev/null
GCE Staff Portal - Access Notes

uni-web login:
username: jannat.lmilali
password: Kx8pQ2vNzL7m
EOF

echo "[*] Lab accounts ready. Starting SSH server..."
exec /usr/sbin/sshd -D -e
