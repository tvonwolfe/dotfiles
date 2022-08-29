local telescope_alternate = require 'telescope-alternate'

telescope_alternate.setup {
  mappings = {
    { 'app/**/*.rb', { { 'spec/[1].rb', 'Test' } } }, -- alternate between file and spec
    { 'app/repositories/[1]_repository.rb', 'Repository' }, -- search/create repositories for the model.
    { 'src/scripts/**/*.js', { { 'spec/**/[1].spec.js', 'Test' } } },
    { 'src/scripts/**/*.ts', { { 'spec/**/[1].spec.ts', 'Test' } } }
  },
  presets = { 'rails', 'rspec' },
}
