#!/usr/bin/env ruby

# require 'tasks/standalone_migrations'
require 'totoslg/boot'

task :shell do
  require 'pry'
  pry
end

namespace :db do

  task :update do
    load File.dirname(__FILE__) + '/db/update.rb'
  end

  task :migrate do
    ActiveRecord::Migrator.migrate('db/migrate')
  end
end
