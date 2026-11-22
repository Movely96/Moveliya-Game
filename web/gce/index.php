<?php
require 'config.php';

if (isset($_SESSION['user'])) { header("Location: dashboard.php"); exit; }

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = (string)($_POST['username'] ?? '');
    $password = (string)($_POST['password'] ?? '');
    if (isset($users[$username]) && password_verify($password, $users[$username])) {
        session_regenerate_id(true);   // prevent session fixation
        $_SESSION['user'] = $username;
        header("Location: dashboard.php");
        exit;
    }
    usleep(500000);                    // small delay slows down web brute-forcing
    $error = "Invalid credentials. Try again.";
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GCE Portal - Login</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="login-box">
<h1>GCE Portal</h1>
<p class="subtitle2">Genie Civil Engineering - Staff Access</p>
<p style="font-size:12px; color:var(--brown-mid); margin-bottom:20px;">
Staff and secretary portal access only. Contact IT support if you've forgotten your credentials.</p>
<?php if (!empty($error)): ?>
<p class="error"><?= htmlspecialchars($error) ?></p>
<?php endif; ?>
<form method="POST">
<input type="text" name="username" placeholder="Username" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Login</button>
</form>
<p style="margin-top:18px; font-size:13px;">
<a href="home.php" style="color:var(--brown-mid);">Back to Home</a></p>
</div>
</body>
</html>
