local telescope_alternate = require 'telescope-alternate'

telescope_alternate.setup {
  mappings = {
    { 'app/**/*.rb', { { 'spec/[1].rb', 'Test' } } }, -- alternate between file and spec
    { 'app/models/*.rb', {
        { 'app/repositories/[1]_repository.rb', 'Repository' },
        { 'app/serializers/[1]_serializer.rb', 'Serializer' },
      },
    },
    { 'src/scripts/**/*.js', { { 'spec/**/[1].spec.js', 'Test' } } },
    { 'src/scripts/**/*.ts', { { 'spec/**/[1].spec.ts', 'Test' } } },
  },
  presets = { 'rails', 'rspec' },
  open_only_one_with = 'vertical_split',
}
