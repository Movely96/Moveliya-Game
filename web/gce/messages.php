<?php
session_start();
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
$user = $_SESSION['user'];
?>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Messages</title><link rel="stylesheet" href="style.css"></head>
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
<div class="news-item"><h3>YARBIIII SALAAMAAAA MN HAD LKUSSALA YALAATIF</h3></div>
<?php else: ?>
<div class="news-item">No new messages.</div>
<?php endif; ?>
</div>
</div></body></html>
