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
<?php if ($user === "abdelmajid.nassit"): ?>
<div class="news-item">Monday - Director's Meetings - 9:00 AM</div>
<div class="news-item">Wednesday - Budget Review - 10:00 AM</div>
<div class="news-item">Friday - Exam Committee - 2:00 PM</div>
<?php elseif ($user === "mehdi.medali"): ?>
<div class="news-item">Monday - Structural Mechanics (Lecture) - 9:00 AM</div>
<div class="news-item">Tuesday - Structural Mechanics (Lab) - 1:00 PM</div>
<div class="news-item">Thursday - Seismic Engineering - 11:00 AM</div>
<?php elseif ($user === "jannat.lmilali"): ?>
<div class="news-item">Monday - Structural Mechanics - 9:00 AM (Prof. Med Ali)</div>
<div class="news-item">Monday - Geotechnical Engineering - 11:00 AM (Prof. Nassit)</div>
<div class="news-item">Wednesday - Construction Management - 10:00 AM</div>
<div class="news-item">Friday - Structural Mechanics Lab - 2:00 PM</div>
<?php endif; ?>
</div>
</div></body></html>
