/*
    SPDX-License-Identifier: AGPL-3.0-or-later
    SPDX-FileCopyrightText: 2025 Shomy
*/
use std::path::PathBuf;

use anyhow::Result;
use async_trait::async_trait;
use clap::Args;
use human_bytes::human_bytes;
use log::info;
use penumbra::Device;

use crate::cli::MtkCommand;
use crate::cli::common::{CONN_DA, DaArgs};
use crate::cli::state::PersistedDeviceState;

#[derive(Args, Debug)]
pub struct PgptArgs {
    #[command(flatten)]
    pub da: DaArgs,
}

#[async_trait]
impl MtkCommand for PgptArgs {
    async fn run(&self, dev: &mut Device, state: &mut PersistedDeviceState) -> Result<()> {
        dev.enter_da_mode().await?;

        state.connection_type = CONN_DA;
        state.flash_mode = 1;

        let partitions = dev.dev_info.partitions().await;

        info!("Partition Table:");
        for p in partitions {
            info!(
                "Name: {:<15} \t Addr: 0x{:08X} \t Size: 0x{:08X} ({})",
                p.name,
                p.address,
                p.size,
                human_bytes(p.size as f64)
            );
        }

        Ok(())
    }

    fn da(&self) -> Option<&PathBuf> {
        Some(&self.da.da_file)
    }
}
