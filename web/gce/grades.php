<?php
$title = 'Grades'; $active = 'grades';
include 'includes/portal_header.php';

$students = [
    "Structural Mechanics" => [
        ["name" => "Saad El Allali",     "grade" => 4],
        ["name" => "Hiba El Miknassi",   "grade" => 8],
        ["name" => "Youssef Amrani",     "grade" => 17],
        ["name" => "Karim Bennani",      "grade" => 14],
    ],
    "Geotechnical Engineering" => [
        ["name" => "Salma Tazi",         "grade" => 18],
        ["name" => "Anas Ouazzani",      "grade" => 11],
        ["name" => "Yasmine El Fassi",   "grade" => 16],
        ["name" => "Ayoub Lahlou",       "grade" => 9],
    ],
    "Construction Management" => [
        ["name" => "Omar Benjelloun",    "grade" => 13],
        ["name" => "Sara Idrissi",       "grade" => 19],
    ],
];

// Class averages are computed from the rosters so the numbers always agree.
function class_average(array $roster): string {
    return number_format(array_sum(array_column($roster, 'grade')) / count($roster), 2);
}

$selected = (string)($_GET['class'] ?? '');
?>
<h1>Grades</h1>
<?php if ($user === "jannat.lmilali"): ?>
<?php if ($selected !== '' && isset($students[$selected])): ?>
<h2 style="color:var(--brown-mid); margin-bottom:14px;"><?= htmlspecialchars($selected) ?> - Student Roster</h2>
<?php foreach ($students[$selected] as $s): ?>
<div class="news-item"><?= htmlspecialchars($s['name']) ?> - <?= (int)$s['grade'] ?>/20</div>
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
<div class="news-item">Structural Mechanics - Class Average: <?= class_average($students["Structural Mechanics"]) ?>/20</div>
<?php elseif ($user === "abdelmajid.nassit"): ?>
<?php foreach ($students as $className => $roster): ?>
<div class="news-item"><?= htmlspecialchars($className) ?> - Class Average: <?= class_average($roster) ?>/20</div>
<?php endforeach; ?>
<?php endif; ?>
<?php include 'includes/portal_footer.php'; ?>
