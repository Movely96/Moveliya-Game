<?php
// Public site header. Set $title and $active (nav item) before including.
$title  = $title  ?? 'GCE - Genie Civil Engineering School';
$active = $active ?? '';
$nav = [
    'home'     => ['home.php',     'Home'],
    'about'    => ['about.php',    'About'],
    'programs' => ['programs.php', 'Programs'],
    'news'     => ['news.php',     'News'],
    'staff'    => ['staff.php',    'Staff'],
    'gallery'  => ['gallery.php',  'Gallery'],
    'faq'      => ['faq.php',      'FAQ'],
    'contact'  => ['contact.php',  'Contact'],
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
<div class="topbar"><span>Tel: +212 5 23 00 00 00 | Email: contact@gce-edu.ma</span><span>Mon - Fri: 08:30 - 17:00</span></div>
<nav class="navbar">
<div class="brand">GCE</div>
<div class="nav-links">
<?php foreach ($nav as $key => [$href, $label]): ?>
<a href="<?= $href ?>"<?= $key === $active ? ' class="active"' : '' ?>><?= $label ?></a>
<?php endforeach; ?>
</div>
<a href="index.php" class="btn-outline">Portal Login</a>
</nav>
