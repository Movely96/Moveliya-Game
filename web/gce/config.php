<?php
// Shared config: starts the session (once) and holds the portal accounts.
// Passwords are stored as bcrypt hashes and checked with password_verify().
if (session_status() === PHP_SESSION_NONE) {
    session_start([
        'cookie_httponly' => true,
        'cookie_samesite' => 'Lax',
    ]);
}

$users = [
    "abdelmajid.nassit" => '$2y$10$kfwmeMs7tAazBsXfpVlo1euHZQiOsaOxwpShUOQlbW/Xl4xIXuNwe',
    "mehdi.medali"      => '$2y$10$IP6f6hZ5D3gRSBvoTSuBgugIFmLayZbk9vE3d1xwI9QL3jR43tfQS',
    "jannat.lmilali"    => '$2y$10$Yr6WlqMfNsqPSvR5QOiKZOf.anF.4XE1OJqM7j1NKR0P52wYcwCs.',
];
