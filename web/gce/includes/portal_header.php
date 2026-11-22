<?php
// Portal header: loads config/session, blocks anonymous visitors, draws the sidebar.
// Set $title and $active (sidebar item) before including. Provides $user.
require_once __DIR__ . '/../config.php';
if (!isset($_SESSION['user'])) { header("Location: index.php"); exit; }
$user   = $_SESSION['user'];
$title  = $title  ?? 'GCE Portal';
$active = $active ?? '';
$menu = [
    'dashboard' => ['dashboard.php', 'Home'],
    'profile'   => ['profile.php',   'Profile'],
    'schedule'  => ['schedule.php',  'Schedule'],
    'grades'    => ['grades.php',    'Grades'],
    'messages'  => ['messages.php',  'Messages'],
    'exams'     => ['exams.php',     'Exams'],
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= htmlspecialchars($title) ?></title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="portal-layout">
<nav class="icon-sidebar"><div class="sidebar-logo">GCE</div>
<?php foreach ($menu as $key => [$href, $label]): ?>
<a href="<?= $href ?>"<?= $key === $active ? ' class="active"' : '' ?>><?= $label ?></a>
<?php endforeach; ?>
<a href="logout.php" class="logout-link">Logout</a></nav>
<div class="portal-content">
