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
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Grades</title><link rel="stylesheet" href="style.css"></head>
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
<?php elseif ($user === "abdelmajid.nassit"): ?>
<div class="news-item">Structural Mechanics - Class Average: 14.5/20</div>
<div class="news-item">Geotechnical Engineering - Class Average: 13.8/20</div>
<div class="news-item">Construction Management - Class Average: 16.0/20</div>
<?php endif; ?>
</div>
</div></body></html>
