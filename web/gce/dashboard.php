<?php
session_start();
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
$user = $_SESSION['user'];
?>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Dashboard</title><link rel="stylesheet" href="style.css"></head>
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
<?php if ($user === "abdelmajid.nassit"): ?>
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
