fn main() { let _ = tokio::net::UnixListener::bind("/tmp/socket.sock"); }
