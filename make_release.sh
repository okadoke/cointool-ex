mix deps.get --only prod
MIX_ENV=prod mix compile
cd assets
npm run deploy
cd ..
mix phx.digest
MIX_ENV=prod mix release