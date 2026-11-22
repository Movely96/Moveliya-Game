<?php $title = 'Messages'; $active = 'messages'; include 'includes/portal_header.php'; ?>
<h1>Messages</h1>
<?php if ($user === "jannat.lmilali"): ?>
<img src="assets/s.jpeg" alt="notification" style="max-width:200px; border-radius:8px; margin-bottom:16px;">
<div class="news-item"><h3>Rattrapage Request - Saad El Allali</h3><p>Requesting a makeup exam for Structural Mechanics.</p></div>
<div class="news-item"><h3>Rattrapage Request - Hiba El Miknassi</h3><p>Requesting a makeup exam for Structural Mechanics.</p></div>
<div class="news-item"><h3>Rattrapage Request - Ayoub Lahlou</h3><p>Requesting a makeup exam for Geotechnical Engineering.</p></div>
<div class="news-item"><h3>Reminder</h3><p>Final exam papers must be printed and sealed before Friday.</p></div>
<?php else: ?>
<div class="news-item">No new messages.</div>
<?php endif; ?>
<?php include 'includes/portal_footer.php'; ?>
