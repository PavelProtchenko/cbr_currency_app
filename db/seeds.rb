# Fill database with currencies for last month
if Rake::Task.task_defined?('import:last_month_currencies')
  Rake::Task['import:last_month_currencies'].invoke
else
  puts "Rake task 'import:last_month_currencies' not found"
end
