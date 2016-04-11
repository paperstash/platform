#!/usr/bin/env rackup

require_relative 'config/application'
require_relative 'config/environment'

# TODO(mtwilliams): Mount on specific domains.
run PaperStash::App
