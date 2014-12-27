require 'resque'

module RetriedJob
  def on_failure_retry(e, *args)
    puts "Performing #{self} caused an exception (#{e}). Retrying..."
    $stdout.flush
    Resque.enqueue self, *args
  end
end

class UpdateCounts
  extend RetriedJob

  @queue = :counts
  puts "Updating Counts!!!!!"

  def self.perform
    puts "Performing Update Counts!!!!!"
  rescue Resque::TermException
    Resque.enqueue(self)
  end
end

# module FailingJob
#   @queue = :failing

#   def self.perform(params)
#     sleep 1
#     raise 'not processable!'
#     puts "Processed a job!"
#   end
# end
