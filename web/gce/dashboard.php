<?php $title = 'Dashboard'; $active = 'dashboard'; include 'includes/portal_header.php'; ?>
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
<?php include 'includes/portal_footer.php'; ?>
