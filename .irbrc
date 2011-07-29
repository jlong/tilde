# Completion
require 'irb/completion'
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Benchmarking utility method
def time(times = 1)
  require 'benchmark'
  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end

# Source for method
class Object
  def method_source(method)
    location = self.method(method).source_location
    `mate #{location[0]} -l #{location[1]}` if location
    location
  end
end
