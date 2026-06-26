// SPDX-License-Identifier: GPL-3.0-only

use serde::{Deserialize, Serialize};
use std::path::PathBuf;
use std::{fs, io};

#[derive(Serialize, Deserialize, Debug)]
pub struct SessionTab {
    pub path: Option<PathBuf>,
    pub backup_path: Option<PathBuf>,
    pub is_modified: bool,
    #[serde(default)]
    pub mtime: Option<u64>,
}

#[derive(Serialize, Deserialize, Debug, Default)]
pub struct Session {
    pub tabs: Vec<SessionTab>,
    pub active_tab_index: Option<usize>,
    #[serde(default)]
    pub projects: Vec<PathBuf>,
}

impl Session {
    pub fn load() -> Self {
        let path = session_file_path();
        if path.exists() {
            match fs::read_to_string(&path) {
                Ok(content) => match serde_json::from_str::<Session>(&content) {
                    Ok(session) => session,
                    Err(err) => {
                        log::error!("failed to parse session file: {}", err);
                        Self::default()
                    }
                },
                Err(err) => {
                    log::error!("failed to read session file: {}", err);
                    Self::default()
                }
            }
        } else {
            Self::default()
        }
    }

    pub fn save(&self) -> io::Result<()> {
        let path = session_file_path();
        if let Some(parent) = path.parent() {
            fs::create_dir_all(parent)?;
        }
        let content = serde_json::to_string_pretty(self)
            .map_err(|e| io::Error::new(io::ErrorKind::Other, e))?;
        fs::write(path, content)
    }
}

pub fn session_file_path() -> PathBuf {
    dirs::config_dir()
        .unwrap_or_else(|| PathBuf::from("."))
        .join("cosmic-edit")
        .join("session.json")
}

pub fn backups_dir_path() -> PathBuf {
    dirs::cache_dir()
        .unwrap_or_else(|| PathBuf::from("."))
        .join("cosmic-edit")
        .join("backups")
}
