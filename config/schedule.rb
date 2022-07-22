# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
env :PATH, ENV['PATH']
set :output, "#{path}/log/cron.log"
set :job_template, nil

job_type :runner,  "cd :path && bundle exec bin/rails runner -e :environment ':task' :output"
every 1.minute do 
  command "ruby -v"
  # pp 'plus 1 minute'
  # runner AddTemperatureJob.perform_now
  runner "Temperature.start"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
