use std::os::unix::net::{UnixListener, UnixStream};
use std::io::{Read, Write};
fn main() {
    let _ = UnixListener::bind("/tmp/test.sock");
}
