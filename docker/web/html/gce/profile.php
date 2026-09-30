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
