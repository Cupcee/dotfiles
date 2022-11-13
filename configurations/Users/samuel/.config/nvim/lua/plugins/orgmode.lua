-- Load custom tree-sitter grammar for org filetype

require('orgmode').setup({
  org_agenda_files = {'~/my-orgs/**/*'},
  org_default_notes_file = '~/org/notes.org',
})
