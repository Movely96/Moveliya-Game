<?php $title = 'Schedule'; $active = 'schedule'; include 'includes/portal_header.php'; ?>
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
<?php include 'includes/portal_footer.php'; ?>
