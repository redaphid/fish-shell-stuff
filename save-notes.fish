#!/usr/bin/env fish
function save-notes --description 'a simple function to save my notes' --argument message
  git-save ~/Projects/notes $message;
end
status is-interactive; or save-notes $argv
