# Introductory SwitchTower config for Dreamhost.
#
# ORIGINAL BY: Jamis Buck
#
# Docs: http://manuals.rubyonrails.com/read/chapter/98
#
# HIGHLY MODIFIED BY: Geoffrey Grosenbach boss@topfunky.com
#
# Docs: http://nubyonrails.com/pages/shovel_dreamhost
#
# USE AT YOUR OWN RISK! THIS SCRIPT MODIFIES FILES, MAKES DIRECTORIES, AND STARTS
# PROCESSES. FOR ADVANCED OR DARING USERS ONLY!
#
# DESCRIPTION
#
# This is a customized recipe for easily deploying web apps to a shared host.
#
# You also need to modify Apache's document root using Dreamhost's web control panel.
#
# For full details, see http://nubyonrails.com/pages/shovel_dreamhost
#
# To setup lighty, first edit this file for your primary Dreamhost account.
#
# Then run:
#   rake remote_exec ACTION=setup
#
# This will create all the necessary directories for running Switchtower.
#
# From then, you can deploy your application with Switchtower's standard
#   rake deploy
#
# Or rollback with
#   rake rollback
# 
# This defines a deployment "recipe" that you can feed to switchtower
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

set :user, 'alexkroman'
set :application, "droppad.com"
set :repository, "file:///home/#{user}/svn/#{application}"
# NOTE: If file:/// doesn't work for you, try this:
#set :repository, "svn+ssh://home/#{user}/svn/#{application}"


# =============================================================================
# You shouldn't have to modify the rest of these
# =============================================================================

role :web, application
role :app, application
role :db,  application, :primary => true

set :deploy_to, "/home/#{user}/#{application}"
# set :svn, "/path/to/svn"       # defaults to searching the PATH
set :use_sudo, false

desc "Restart the FCGI processes on the app server as a regular user."
task :restart, :roles => :app do
  run "#{current_path}/script/process/reaper --dispatcher=dispatch.fcgi"
end
