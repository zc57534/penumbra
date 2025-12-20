/*
    SPDX-License-Identifier: AGPL-3.0-or-later
    SPDX-FileCopyrightText: 2025 Shomy
*/
#[macro_use]
mod macros;
mod app;
mod cli;
mod components;
mod error;
mod logger;
mod pages;

use anyhow::Result;
use app::App;
use clap::Parser;
use cli::{CliArgs, run_cli};
use logger::init_logger;

#[tokio::main]
async fn main() -> Result<()> {
    let args = CliArgs::parse();

    let cli_mode = args.cli || args.command.is_some();
    let tui_mode = !cli_mode;

    init_logger(tui_mode, args.verbose);

    if cli_mode {
        return run_cli(&args).await;
    }

    let mut terminal = ratatui::init();
    let mut app = App::new(&args);

    let app_result = app.run(&mut terminal).await;

    ratatui::restore();
    app_result
}
