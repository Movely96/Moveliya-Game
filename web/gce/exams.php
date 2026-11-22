<?php $title = 'GCE Portal - Exams'; $active = 'exams'; include 'includes/portal_header.php'; ?>
<?php if ($user === "jannat.lmilali"): ?>
<h1>Final Exam - Structural Mechanics</h1>
<img src="assets/right.jpeg" alt="Access granted" style="max-width:300px; border-radius:8px; margin-bottom:16px;">
<div class="exam-box">
<p><strong><?= htmlspecialchars(base64_decode('RkxBR3tnY2VfZXhhbV9sZWFrZWRfNTQyY2ZhMWF9')) ?></strong></p>
<p>CONGRATS U DID IT DATEBAAYOO</p>
</div>
<?php else: ?>
<h1 class="lose">U LOSE DATTEBAAYOO HAHA</h1>
<img src="assets/wrong.jpeg" alt="Access denied" style="max-width:300px; border-radius:8px; margin-top:16px;">
<p>This account doesn't handle exam administration. Re-read the OSINT materials: who manages the exams?</p>
<?php endif; ?>
<?php include 'includes/portal_footer.php'; ?>
