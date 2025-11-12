#[macro_export]
macro_rules! mtk_commands {
    ( $( $variant:ident ( $ty:ty ) ),+ $(,)? ) => {
        #[derive(clap::Subcommand, Debug)]
        pub enum Commands {
            $(
                $variant($ty),
            )+
        }

        #[async_trait::async_trait]
        impl crate::cli::MtkCommand for Commands {
            fn da(&self) -> Option<&std::path::PathBuf> {
                match self {
                    $(
                        Commands::$variant(inner) => inner.da(),
                    )+
                }
            }

            async fn run(
                &self,
                dev: &mut penumbra::Device,
                state: &mut crate::cli::state::PersistedDeviceState,
            ) -> anyhow::Result<()> {
                match self {
                    $(
                        Commands::$variant(inner) => inner.run(dev, state).await,
                    )+
                }
            }
        }
    };
}

pub(crate) use mtk_commands;
