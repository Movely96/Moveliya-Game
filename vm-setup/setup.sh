#!/bin/bash

set -e

echo "   MOVELIYA GAME - Lab Setup Script"

# ---- Step 1: Create Linux accounts ----
echo "[*] Creating user accounts..."
sudo useradd -m sandal 2>/dev/null || true
echo "sandal:Sandal1973" | sudo chpasswd

sudo useradd -m mehdi 2>/dev/null || true
echo "mehdi:Lilm1980" | sudo chpasswd

sudo useradd -m jannat 2>/dev/null || true
echo "jannat:Mimi2018" | sudo chpasswd


# ---- Step 2: Populate home folders ----
echo "[*] Populating home directories..."
sudo -u sandal mkdir -p /home/sandal/Pictures /home/sandal/Documents
sudo -u sandal touch /home/sandal/Pictures/family_photo.jpg
sudo -u sandal touch /home/sandal/Pictures/graduation_1996.jpg
sudo -u sandal touch /home/sandal/Pictures/barcelona_match.jpg
echo "Meeting with FSTBM alumni association next week." | sudo -u sandal tee /home/sandal/Documents/notes.txt > /dev/null

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

# ---- Step 3: Hidden files with web credentials ----
echo "[*] Planting hidden credential files..."

sudo -u sandal mkdir -p /home/sandal/.hidden
cat <<'EOF' | sudo -u sandal tee /home/sandal/.hidden/portal_access.txt > /dev/null
GCE Staff Portal - Access Notes

uni-web login:
username: abdelmajid.sandal
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


# ---- Step 4: Install Apache + PHP ----
echo "[*] Installing Apache + PHP (this may take a minute)..."
sudo apt update -qq
sudo apt install -y apache2 php libapache2-mod-php php-cli -qq
sudo systemctl enable apache2 -q
sudo systemctl start apache2

# ---- Step 5: Build the GCE website ----
echo "[*] Building GCE website..."
sudo mkdir -p /var/www/html/gce/assets

sudo tee /var/www/html/robots.txt > /dev/null <<'EOF'
User-agent: *
Disallow: /gce/
EOF

sudo tee /var/www/html/gce/config.php > /dev/null <<'EOF'
<?php
session_start();
$users = [
    "abdelmajid.sandal" => "Bagzhgu4yft7",
    "mehdi.medali"      => "Dh5fbueR4mQA",
    "jannat.lmilali"    => "Kx8pQ2vNzL7m",
];
?>
EOF



sudo tee /var/www/html/gce/index.php > /dev/null <<'EOF'
<?php
require 'config.php';
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    if (isset($users[$username]) && $users[$username] === $password) {
        $_SESSION['user'] = $username;
        header("Location: dashboard.php");
        exit;
    } else {
        $error = "Invalid credentials. Try again.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>GCE Portal - Login</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="login-box">
<h1>GCE Portal</h1>
<p class="subtitle2">Genie Civil Engineering - Staff Access</p>
<p style="font-size:12px; color:var(--brown-mid); margin-bottom:20px;">
Staff and secretary portal access only. Contact IT support if you've forgotten your credentials.</p>
<?php if (!empty($error)): ?>
<p class="error"><?= htmlspecialchars($error) ?></p>
<?php endif; ?>
<form method="POST">
<input type="text" name="username" placeholder="Username" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Login</button>
</form>
<p style="margin-top:18px; font-size:13px;">
<a href="home.php" style="color:var(--brown-mid);">Back to Home</a></p>
</div>
</body>
</html>
EOF

sudo tee /var/www/html/gce/logout.php > /dev/null <<'EOF'
<?php
session_start();
session_destroy();
header("Location: index.php");
exit;
?>
EOF






sudo tee /var/www/html/gce/style.css > /dev/null <<'EOF'
:root {
    --brown-dark: #2B1B17;
    --brown-mid: #6D4C41;
    --brown-light: #A1887F;
    --cream: #F5F0E8;
    --gold-accent: #C9A063;
    --text-dark: #2B1B17;
}
* { margin: 0; padding: 0; box-sizing: border-box; font-family: Georgia, 'Times New Roman', serif; }
body { background: var(--cream); color: var(--text-dark); }
.topbar { background: var(--brown-dark); color: var(--brown-light); font-size: 12px; padding: 6px 50px; display: flex; justify-content: space-between; }
.navbar { display: flex; align-items: center; justify-content: space-between; padding: 16px 50px; background: var(--cream); border-bottom: 3px solid var(--gold-accent); position: sticky; top: 0; z-index: 100; }
.navbar .brand { color: var(--brown-dark); font-size: 24px; font-weight: bold; }
.navbar .nav-links { display: flex; gap: 26px; }
.navbar .nav-links a { color: var(--brown-dark); text-decoration: none; font-size: 14px; font-weight: 600; }
.navbar .nav-links a:hover, .navbar .nav-links a.active { color: var(--gold-accent); }
.navbar .btn-outline { padding: 9px 22px; background: var(--brown-dark); border-radius: 4px; color: var(--cream); text-decoration: none; font-size: 14px; }
.navbar .btn-outline:hover { background: var(--gold-accent); color: var(--brown-dark); }
.hero { background: linear-gradient(rgba(43,27,23,0.88), rgba(43,27,23,0.88)); color: var(--cream); text-align: center; padding: 100px 20px; }
.hero h1 { font-size: 46px; margin-bottom: 14px; }
.hero p { font-size: 17px; color: var(--brown-light); margin-bottom: 24px; }
.hero .btn-cta { display: inline-block; padding: 12px 30px; background: var(--gold-accent); color: var(--brown-dark); text-decoration: none; border-radius: 4px; font-weight: bold; }
.section { max-width: 1100px; margin: 0 auto; padding: 70px 20px; }
.section h2 { color: var(--brown-dark); font-size: 30px; margin-bottom: 10px; text-align: center; }
.section .subtitle { text-align: center; color: var(--brown-mid); margin-bottom: 40px; }
.page { max-width: 950px; margin: 0 auto; padding: 50px 20px; }
.page h1 { color: var(--brown-dark); border-bottom: 3px solid var(--gold-accent); padding-bottom: 12px; margin-bottom: 24px; }
.page p { line-height: 1.7; margin-bottom: 14px; }
.card-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 22px; }
.card { background: white; border: 1px solid var(--brown-light); border-top: 4px solid var(--gold-accent); padding: 26px; border-radius: 4px; }
.card h3 { color: var(--brown-dark); margin-bottom: 8px; }
.leader-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 26px; }
.leader-card { background: white; border: 1px solid var(--brown-light); text-align: center; padding: 30px 20px; border-radius: 6px; }
.leader-avatar { width: 90px; height: 90px; border-radius: 50%; background: var(--brown-mid); margin: 0 auto 16px; display: flex; align-items: center; justify-content: center; color: var(--cream); font-size: 30px; font-weight: bold; }
.leader-photo { width: 90px; height: 90px; border-radius: 50%; object-fit: cover; margin: 0 auto 16px; display: block; border: 3px solid var(--gold-accent); }
.leader-card h3 { color: var(--brown-dark); margin-bottom: 4px; }
.leader-card .role { color: var(--gold-accent); font-size: 13px; font-weight: bold; margin-bottom: 10px; }
.leader-card p { font-size: 13px; color: var(--brown-mid); }
.news-item { background: white; border-left: 4px solid var(--gold-accent); padding: 18px; margin-bottom: 16px; }
.news-item h3 { color: var(--brown-dark); margin-bottom: 6px; }
footer { background: var(--brown-dark); color: var(--brown-light); padding: 50px 50px 20px; margin-top: 60px; }
.footer-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 30px; max-width: 1100px; margin: 0 auto; }
.footer-grid h4 { color: var(--gold-accent); margin-bottom: 14px; font-size: 15px; }
.footer-grid a { display: block; color: var(--brown-light); text-decoration: none; font-size: 13px; margin-bottom: 8px; }
.footer-grid a:hover { color: var(--gold-accent); }
.footer-bottom { text-align: center; padding-top: 30px; margin-top: 30px; border-top: 1px solid var(--brown-mid); font-size: 12px; }
.login-box { background: white; border: 1px solid var(--brown-light); border-top: 5px solid var(--gold-accent); border-radius: 6px; padding: 45px 35px; width: 350px; margin: 80px auto; text-align: center; }
.login-box h1 { color: var(--brown-dark); margin-bottom: 4px; }
.subtitle2 { font-size: 13px; color: var(--brown-mid); margin-bottom: 24px; }
.login-box input { width: 100%; padding: 12px; margin-bottom: 14px; border: 1px solid var(--brown-light); border-radius: 4px; outline: none; }
.login-box input:focus { border-color: var(--gold-accent); }
.login-box button { width: 100%; padding: 12px; background: var(--brown-dark); color: var(--cream); border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
.login-box button:hover { background: var(--gold-accent); color: var(--brown-dark); }
.error { color: #a33; font-size: 13px; margin-bottom: 12px; }
.portal-layout { display: flex; min-height: 100vh; }
.icon-sidebar { width: 220px; background: var(--brown-dark); display: flex; flex-direction: column; padding: 20px 0; }
.sidebar-logo { color: var(--gold-accent); font-weight: bold; font-size: 20px; padding: 0 24px 24px; }
.icon-sidebar a { display: flex; align-items: center; gap: 14px; padding: 14px 24px; color: var(--cream); text-decoration: none; font-size: 15px; }
.icon-sidebar a:hover, .icon-sidebar a.active { background: var(--brown-mid); color: var(--gold-accent); }
.icon-sidebar .logout-link { margin-top: auto; border-top: 1px solid var(--brown-mid); }
.portal-content { flex: 1; padding: 40px; background: var(--cream); }
.portal-content h1 { color: var(--brown-dark); margin-bottom: 20px; }
.exam-box { background: white; border: 1px dashed var(--gold-accent); padding: 20px; border-radius: 6px; margin: 20px 0; word-break: break-all; }
.lose { color: #a33; }
EOF




sudo tee /var/www/html/gce/home.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE - Genie Civil Engineering School</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<a href="home.php" class="active">Home</a>
<a href="about.php">About</a>
<a href="programs.php">Programs</a>
<a href="news.php">News</a>
<a href="staff.php">Staff</a>
<a href="gallery.php">Gallery</a>
<a href="faq.php">FAQ</a>
<a href="contact.php">Contact</a>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
<div class="hero">
<h1>Genie Civil Engineering School</h1>
<p>Excellence in Civil Engineering Education Since 2001</p>
<a href="about.php" class="btn-cta">Discover GCE</a>
</div>
<div class="section">
<h2>About GCE</h2>
<p class="subtitle">Training the civil engineers of tomorrow</p>
<p style="text-align:center; max-width:700px; margin:0 auto; line-height:1.7;">
GCE combines rigorous technical training with hands-on practice, preparing students for real careers in structural, geotechnical, and construction engineering.</p>
</div>
<div class="section" style="background:white;">
<h2>Our Leadership</h2>
<p class="subtitle">Guided by experienced educators and administrators</p>
<div class="leader-grid">
<div class="leader-card"><img src="assets/sandal.jpeg" class="leader-photo" alt="Abdelmajid Sandal"><h3>Abdelmajid Sandal</h3><p class="role">Director</p><p>25+ years in civil engineering education, FSTBM alumnus.</p></div>
<div class="leader-card"><img src="assets/mehdi.jpeg" class="leader-photo" alt="Mehdi Med Ali"><h3>Mehdi Med Ali</h3><p class="role">Deputy Director</p><p>Former Structural Mechanics professor, published researcher.</p></div>
<div class="leader-card"><div class="leader-avatar">JL</div><h3>Jannat Lmilali</h3><p class="role">Secretary </p><p>Manages students.</p></div>
</div>
</div>
<div class="section">
<h2>Latest News</h2>
<div class="news-item"><h3>Final Exam Schedule Released</h3><p>Structural Mechanics finals next month. Contact the secretary's office.</p></div>
</div>
<footer>
<div class="footer-grid">
<div><h4>GCE</h4><a href="about.php">About Us</a><a href="programs.php">Programs</a><a href="staff.php">Staff</a></div>
<div><h4>Campus</h4><a href="gallery.php">Gallery</a><a href="news.php">News</a><a href="faq.php">FAQ</a></div>
<div><h4>Contact</h4><a href="contact.php">Contact Us</a><a href="index.php">Portal Login</a></div>
</div>
<div class="footer-bottom">Copyright 2026 GCE - Genie Civil Engineering School. All rights reserved.</div>
</footer>
</body>
</html>
EOF



sudo tee /var/www/html/gce/about.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE - About Us</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<a href="home.php">Home</a><a href="about.php" class="active">About</a><a href="programs.php">Programs</a><a href="news.php">News</a><a href="staff.php">Staff</a><a href="gallery.php">Gallery</a><a href="faq.php">FAQ</a><a href="contact.php">Contact</a>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
<div class="page">
<h1>About GCE</h1>
<p>Founded to train the next generation of civil engineers, GCE (Genie Civil Engineering) has been a cornerstone of technical education in the region for over two decades.</p>
<p>GCE is led by Director Abdelmajid Sandal, alongside Deputy Director Mehdi Med Ali, supported by our dedicated administrative staff including Secretary Jannat Lmilali.</p>
</div>
</body>
</html>
EOF

sudo tee /var/www/html/gce/programs.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE - Programs</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<a href="home.php">Home</a><a href="about.php">About</a><a href="programs.php" class="active">Programs</a><a href="news.php">News</a><a href="staff.php">Staff</a><a href="gallery.php">Gallery</a><a href="faq.php">FAQ</a><a href="contact.php">Contact</a>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
<div class="page">
<h1>Our Programs</h1>
<div class="card-grid">
<div class="card"><h3>Structural Engineering</h3><p>Load-bearing design, materials science, and seismic-resistant structures.</p></div>
<div class="card"><h3>Geotechnical Engineering</h3><p>Soil mechanics, foundation design, and site analysis.</p></div>
<div class="card"><h3>Construction Management</h3><p>Project planning, budgeting, and on-site supervision.</p></div>
</div>
</div>
</body>
</html>
EOF

sudo tee /var/www/html/gce/news.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE - News</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<a href="home.php">Home</a><a href="about.php">About</a><a href="programs.php">Programs</a><a href="news.php" class="active">News</a><a href="staff.php">Staff</a><a href="gallery.php">Gallery</a><a href="faq.php">FAQ</a><a href="contact.php">Contact</a>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
<div class="page">
<h1>Announcements</h1>
<div class="news-item"><h3>Final Exam Schedule Released</h3><p>Structural Mechanics finals next month. Contact the secretary's office.</p></div>
<div class="news-item"><h3>New Deputy Director Appointed</h3><p>We welcome Mehdi Med Ali as our new Deputy Director.</p></div>
</div>
</body>
</html>
EOF

sudo tee /var/www/html/gce/staff.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE - Staff Directory</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<a href="home.php">Home</a><a href="about.php">About</a><a href="programs.php">Programs</a><a href="news.php">News</a><a href="staff.php" class="active">Staff</a><a href="gallery.php">Gallery</a><a href="faq.php">FAQ</a><a href="contact.php">Contact</a>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
<div class="page">
<h1>Staff Directory</h1>
<div class="card-grid">
<div class="card"><h3>Abdelmajid Sandal</h3><p>Director</p></div>
<div class="card"><h3>Mehdi Med Ali</h3><p>Deputy Director</p></div>
<div class="card"><h3>Jannat Lmilali</h3><p>Secretary - Exam Administration</p></div>
</div>
</div>
</body>
</html>
EOF

sudo tee /var/www/html/gce/gallery.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE - Gallery</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<a href="home.php">Home</a><a href="about.php">About</a><a href="programs.php">Programs</a><a href="news.php">News</a><a href="staff.php">Staff</a><a href="gallery.php" class="active">Gallery</a><a href="faq.php">FAQ</a><a href="contact.php">Contact</a>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
<div class="page">
<h1>Campus Gallery</h1>
<div class="card-grid">
<div class="card"><p>Main Building</p></div>
<div class="card"><p>Engineering Lab</p></div>
<div class="card"><p>Library</p></div>
</div>
</div>
</body>
</html>
EOF

sudo tee /var/www/html/gce/contact.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE - Contact</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<a href="home.php">Home</a><a href="about.php">About</a><a href="programs.php">Programs</a><a href="news.php">News</a><a href="staff.php">Staff</a><a href="gallery.php">Gallery</a><a href="faq.php">FAQ</a><a href="contact.php" class="active">Contact</a>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
<div class="page">
<h1>Contact Us</h1>
<p>Email: contact@gce-edu.ma</p>
<p>Phone: +212 5 23 00 00 00</p>
<p>Address: Beni Mellal, Morocco</p>
</div>
</body>
</html>
EOF




sudo tee /var/www/html/gce/faq.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE - FAQ</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<a href="home.php">Home</a><a href="about.php">About</a><a href="programs.php">Programs</a><a href="news.php">News</a><a href="staff.php">Staff</a><a href="gallery.php">Gallery</a><a href="faq.php" class="active">FAQ</a><a href="contact.php">Contact</a>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
<div class="page">
<h1>Frequently Asked Questions</h1>
<div class="news-item"><h3>How do I access my exam schedule?</h3><p>Log into the student portal and check the Exams section.</p></div>
<div class="news-item"><h3>Who do I contact for administrative issues?</h3><p>The administration office handles logistics and records.</p></div>
</div>
</body>
</html>
EOF





sudo tee /var/www/html/gce/dashboard.php > /dev/null <<'EOF'
<?php
session_start();
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
$user = $_SESSION['user'];
?>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Dashboard</title><link rel="stylesheet" href="style.css"></head>
<body><div class="portal-layout">
<nav class="icon-sidebar"><div class="sidebar-logo">GCE</div>
<a href="dashboard.php" class="active">Home</a>
<a href="profile.php">Profile</a>
<a href="schedule.php">Schedule</a>
<a href="grades.php">Grades</a>
<a href="messages.php">Messages</a>
<a href="exams.php">Exams</a>
<a href="logout.php" class="logout-link">Logout</a></nav>
<div class="portal-content">
<h1>Welcome, <?= htmlspecialchars($user) ?></h1>
<?php if ($user === "abdelmajid.sandal"): ?>
<div class="news-item"><h3>Reunion - Exam Committee</h3><p>Today, 2:00 PM - Building A, Conference Room.</p></div>
<div class="news-item"><h3>Budget Review</h3><p>Tomorrow, 10:00 AM - Review Q4 department budget.</p></div>
<div class="news-item"><h3>Pending Signatures</h3><p>3 administrative documents awaiting approval.</p></div>
<?php elseif ($user === "mehdi.medali"): ?>
<div class="news-item"><h3>Structural Mechanics - Grading</h3><p>Midterm grading deadline this Friday.</p></div>
<div class="news-item"><h3>Department Meeting</h3><p>Today, 1:00 PM - Curriculum review with faculty.</p></div>
<div class="news-item"><h3>Lab Equipment Request</h3><p>Pending approval for new equipment.</p></div>
<?php elseif ($user === "jannat.lmilali"): ?>
<div class="news-item"><h3>Emploi du Temps - This Week</h3>
<p>Monday: Structural Mechanics (9:00 AM), Geotechnical Eng. (11:00 AM)</p>
<p>Wednesday: Construction Management (10:00 AM)</p>
<p>Friday: Structural Mechanics Lab (2:00 PM)</p></div>
<div class="news-item"><h3>Documents to Print</h3><p>Deadline: Friday - Department paperwork.</p></div>
<div class="news-item"><h3>Pending Requests</h3><p>3 items awaiting review. Check Messages.</p></div>
<?php endif; ?>
</div>
</div></body></html>
EOF


sudo tee /var/www/html/gce/profile.php > /dev/null <<'EOF'
<?php
session_start();
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
?>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Profile</title><link rel="stylesheet" href="style.css"></head>
<body><div class="portal-layout">
<nav class="icon-sidebar"><div class="sidebar-logo">GCE</div>
<a href="dashboard.php">Home</a>
<a href="profile.php" class="active">Profile</a>
<a href="schedule.php">Schedule</a>
<a href="grades.php">Grades</a>
<a href="messages.php">Messages</a>
<a href="exams.php">Exams</a>
<a href="logout.php" class="logout-link">Logout</a></nav>
<div class="portal-content"><h1>My Profile</h1><p>Username: <?= htmlspecialchars($_SESSION['user']) ?></p></div>
</div></body></html>
EOF

sudo tee /var/www/html/gce/schedule.php > /dev/null <<'EOF'
<?php
session_start();
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
$user = $_SESSION['user'];
?>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Schedule</title><link rel="stylesheet" href="style.css"></head>
<body><div class="portal-layout">
<nav class="icon-sidebar"><div class="sidebar-logo">GCE</div>
<a href="dashboard.php">Home</a>
<a href="profile.php">Profile</a>
<a href="schedule.php" class="active">Schedule</a>
<a href="grades.php">Grades</a>
<a href="messages.php">Messages</a>
<a href="exams.php">Exams</a>
<a href="logout.php" class="logout-link">Logout</a></nav>
<div class="portal-content">
<h1>Class Schedule</h1>
<?php if ($user === "abdelmajid.sandal"): ?>
<div class="news-item">Monday - Director's Meetings - 9:00 AM</div>
<div class="news-item">Wednesday - Budget Review - 10:00 AM</div>
<div class="news-item">Friday - Exam Committee - 2:00 PM</div>
<?php elseif ($user === "mehdi.medali"): ?>
<div class="news-item">Monday - Structural Mechanics (Lecture) - 9:00 AM</div>
<div class="news-item">Tuesday - Structural Mechanics (Lab) - 1:00 PM</div>
<div class="news-item">Thursday - Seismic Engineering - 11:00 AM</div>
<?php elseif ($user === "jannat.lmilali"): ?>
<div class="news-item">Monday - Structural Mechanics - 9:00 AM (Prof. Med Ali)</div>
<div class="news-item">Monday - Geotechnical Engineering - 11:00 AM (Prof. Sandal)</div>
<div class="news-item">Wednesday - Construction Management - 10:00 AM</div>
<div class="news-item">Friday - Structural Mechanics Lab - 2:00 PM</div>
<?php endif; ?>
</div>
</div></body></html>
EOF



sudo tee /var/www/html/gce/grades.php > /dev/null <<'EOF'
<?php
session_start();
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
$user = $_SESSION['user'];
$students = [
    "Structural Mechanics" => [
        ["name" => "Saad El Allali", "grade" => "4/20"],
        ["name" => "Hiba El Miknassi", "grade" => "8/20"],
        ["name" => "Naruto Uzumaki", "grade" => "17/20"],
        ["name" => "Ichigo Kurosaki", "grade" => "14/20"],
    ],
    "Geotechnical Engineering" => [
        ["name" => "Nico Robin", "grade" => "18/20"],
        ["name" => "Monkey D. Luffy", "grade" => "11/20"],
        ["name" => "Yasmine El Fassi", "grade" => "16/20"],
        ["name" => "Eren Yeager(TATAKAE)", "grade" => "09/20"],
    ],
    "Construction Management" => [
        ["name" => "Omar Benjelloun", "grade" => "13/20"],
        ["name" => "Sara Idrissi", "grade" => "19/20"],
    ],
];
$selected = $_GET['class'] ?? null;
?>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Grades</title><link rel="stylesheet" href="style.css"></head>
<body><div class="portal-layout">
<nav class="icon-sidebar"><div class="sidebar-logo">GCE</div>
<a href="dashboard.php">Home</a>
<a href="profile.php">Profile</a>
<a href="schedule.php">Schedule</a>
<a href="grades.php" class="active">Grades</a>
<a href="messages.php">Messages</a>
<a href="exams.php">Exams</a>
<a href="logout.php" class="logout-link">Logout</a></nav>
<div class="portal-content">
<h1>Grades</h1>
<?php if ($user === "jannat.lmilali"): ?>
<?php if ($selected && isset($students[$selected])): ?>
<h2 style="color:var(--brown-mid); margin-bottom:14px;"><?= htmlspecialchars($selected) ?> - Student Roster</h2>
<?php foreach ($students[$selected] as $s): ?>
<div class="news-item"><?= htmlspecialchars($s['name']) ?> - <?= htmlspecialchars($s['grade']) ?></div>
<?php endforeach; ?>
<p style="margin-top:20px;"><a href="grades.php" style="color:var(--brown-mid);">Back to Classes</a></p>
<?php else: ?>
<div class="card-grid">
<?php foreach ($students as $className => $roster): ?>
<a href="grades.php?class=<?= urlencode($className) ?>" style="text-decoration:none;">
<div class="card"><h3><?= htmlspecialchars($className) ?></h3><p><?= count($roster) ?> students</p></div>
</a>
<?php endforeach; ?>
</div>
<?php endif; ?>
<?php elseif ($user === "mehdi.medali"): ?>
<div class="news-item">Structural Mechanics - Class Average: 14.5/20</div>
<div class="news-item">Structural Mechanics Lab - Class Average: 15.2/20</div>
<?php elseif ($user === "abdelmajid.sandal"): ?>
<div class="news-item">Structural Mechanics - Class Average: 14.5/20</div>
<div class="news-item">Geotechnical Engineering - Class Average: 13.8/20</div>
<div class="news-item">Construction Management - Class Average: 16.0/20</div>
<?php endif; ?>
</div>
</div></body></html>
EOF

sudo tee /var/www/html/gce/messages.php > /dev/null <<'EOF'
<?php
session_start();
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
$user = $_SESSION['user'];
?>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Messages</title><link rel="stylesheet" href="style.css"></head>
<body><div class="portal-layout">
<nav class="icon-sidebar"><div class="sidebar-logo">GCE</div>
<a href="dashboard.php">Home</a>
<a href="profile.php">Profile</a>
<a href="schedule.php">Schedule</a>
<a href="grades.php">Grades</a>
<a href="messages.php" class="active">Messages</a>
<a href="exams.php">Exams</a>
<a href="logout.php" class="logout-link">Logout</a></nav>
<div class="portal-content">
<h1>Messages</h1>
<?php if ($user === "jannat.lmilali"): ?>
<img src="assets/s.jpeg" alt="notification" style="max-width:200px; border-radius:8px; margin-bottom:16px;">
<div class="news-item"><h3>Rattrapage Request - Saad El Allali</h3><p>Requesting a makeup exam for Structural Mechanics.</p></div>
<div class="news-item"><h3>Rattrapage Request - Hiba El Miknassi</h3><p>Requesting a makeup exam for Geotechnical Engineering.</p></div>
<div class="news-item"><h3>Rattrapage Request - Eren Yeager</h3><p>Requesting a makeup exam for Structural Mechanics.</p></div>
<div class="news-item"><h3>YARBIIII SALAAMAAAA MN HAD LKUSSALA YALAATIF</h3>
<?php else: ?>
<div class="news-item">No new messages.</div>
<?php endif; ?>
</div>
</div></body></html>
EOF




sudo tee /var/www/html/gce/exams.php > /dev/null <<'EOF'
<?php
session_start();
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
$user = $_SESSION['user'];
?>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GCE Portal - Exams</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="portal-layout">
<nav class="icon-sidebar"><div class="sidebar-logo">GCE</div>
<a href="dashboard.php">Home</a>
<a href="profile.php">Profile</a>
<a href="schedule.php">Schedule</a>
<a href="grades.php">Grades</a>
<a href="messages.php">Messages</a>
<a href="exams.php" class="active">Exams</a>
<a href="logout.php" class="logout-link">Logout</a>
</nav>
<div class="portal-content">
<?php if ($user === "jannat.lmilali"): ?>
<h1>Final Exam - Structural Mechanics</h1>
<img src="assets/right.jpeg" alt="right" style="max-width:300px; border-radius:8px; margin-bottom:16px;">
<div class="exam-box">
<p><strong>FLAG{gce_exam_leaked_2026}</strong></p>
<p>Congrats, you found it Waiting FOR U IN S2 OF THIS GAME.</p>
</div>
<?php else: ?>
<h1 class="lose">u lose go study for ur test Kido</h1>
<img src="assets/wrong.jpeg" alt="wrong" style="max-width:300px; border-radius:8px; margin-top:16px;">
<p>Wrong account, try again with better OSINT. Or U can always give up on the game ur a loser anyway</p>
                          <p>DATTEBAAYOO</p>
<?php endif; ?>
</div>
</div>
</body>
</html>
EOF

# ---- Copy character images ----
echo "[*] Copying images..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo cp "$SCRIPT_DIR/assets/sandal.jpeg" /var/www/html/gce/assets/sandal.jpeg
sudo cp "$SCRIPT_DIR/assets/mehdi.jpeg" /var/www/html/gce/assets/mehdi.jpeg
sudo cp "$SCRIPT_DIR/assets/wrong.jpeg" /var/www/html/gce/assets/wrong.jpeg
sudo cp "$SCRIPT_DIR/assets/right.jpeg" /var/www/html/gce/assets/right.jpeg
sudo cp "$SCRIPT_DIR/assets/s.jpeg" /var/www/html/gce/assets/s.jpeg

echo "[*] Web files created. Fixing permissions..."
sudo chown -R www-data:www-data /var/www/html/gce
sudo chmod -R 755 /var/www/html/gce

echo "   SETUP COMPLETE"
echo "   Your lab environment is ready."
echo "   Time to start investigating."
