#![deny(clippy::pedantic)]

use std::{os::unix::process::CommandExt, process::Command};

use clap::Parser;

#[derive(Debug, Clone, PartialEq, Eq, clap::Parser)]
struct Cli {
    #[command(subcommand)]
    command: Subcommand,
}

#[derive(Debug, Clone, PartialEq, Eq, clap::Subcommand)]
enum Subcommand {
    List,
    Delete { start: usize, end: usize },
}

const SYSTEM_PROFILE: &str = "/nix/var/nix/profiles/system";

fn main() {
    let args = Cli::parse();
    let mut command = Command::new("nix-env");
    command.args(["--profile", SYSTEM_PROFILE]);

    match args.command {
        Subcommand::List => {
            command.arg("--list-generations");
        }
        Subcommand::Delete { start, end } => {
            command.arg("--delete-generations");
            command.args((start..=end).map(|n| n.to_string()));
        }
    }

    let error = command.exec();

    panic!("{error}");
}
