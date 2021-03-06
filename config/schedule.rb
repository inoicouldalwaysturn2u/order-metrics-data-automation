# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# examples (--help for more)
# wheneverize .
# whenever --update-crontab

# set :output, 'log/cron_log.log'
set :output, 'log/cron_log.log'

##
# Main app stuff
##

# early hours - hourly
every '0 1,3,5 * * *' do
  rake 'core:run'
end
every '0 2,4,6 * * *' do
  rake 'core:run'
end

# try to get the last one for the day. 2 min before midnight for enough time to do everything. As it normally takes a minute or slightly more.
# could potentially reduce to 1 min, but that could possibly cause a few seconds into next day if system is slow/bogged down, if logging in needs to happen, internet is slow, service is slow, et al.
every '58 23 * * *' do
  rake 'core:run'
end

# 8 am to 11 pm, every 30 min - at hour mark
every '0 7,9,11,13,15,17,19,21,23 * * *' do
  rake 'core:run'
end
# 8 am to 11 pm, every 30 min - at hour mark
every '0 8,10,12,14,16,18,20,22 * * *' do
  rake 'core:run'
end

# 8 am to 11 pm, every 30 min - at 30 min mark
every '30 7,9,11,13,15,17,19,21 * * *' do
  rake 'core:run'
end
# 8 am to 11 pm, every 30 min - at hour mark
every '30 8,10,12,14,16,18,20,22 * * *' do
  rake 'core:run'
end


##
# Process managing
##

# Once an hour, 2 minutes before xvfb
every '4 * * * *' do
  rake 'main_app:kill_zombie_chrome'
end

# Once an hour, 2 minutes after chrome
every '6 * * * *' do
  rake 'main_app:kill_zombie_xvfb'
end

# Once every 6 hours, 2 minutes after both
# every '5 1,7,13,19 * * *' do
# Once every 4 hours, 2 minutes after both
every '8 1,5,9,13,17,21 * * *' do
  rake 'main_app:kill_any_and_all_zombies'
end
