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
