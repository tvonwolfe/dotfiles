local telescope_alternate = require 'telescope-alternate'

telescope_alternate.setup {
  mappings = {
    {
      'app/**/(.*).rb',
      { { 'spec/[1]_spec.rb', 'Test' } },
    },
    { 'app/models/(.*).rb',
      {
        { 'app/repositories/[1]_repository.rb',             'Repository' },
        { 'app/serializers/[1]_serializer.rb',              'Serializer' },
        { 'app/helpers/[1:pluralize]_helper.rb',            'Helper' },
        { 'app/controllers/**/[1:pluralize]_controller.rb', 'Controller' },
        { 'spec/factories/[1:pluralize].rb',                'Factory' },
      },
    },
    { 'src/scripts/**/*.js', { { 'spec/**/[1].spec.js', 'Test' } } },
    { 'src/scripts/**/*.ts', { { 'spec/**/[1].spec.ts', 'Test' } } },
  },
  presets = { 'rails', 'rspec' },
}
