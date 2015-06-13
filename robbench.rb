#!/usr/bin/env ruby

require 'benchmark'

puts "Rob's Quick Ruby Benchmark - Version 1.00"
puts "Copyright (C) 2015 Robert W. Oliver II <rob@ocstech.com>"
puts "Licensed under the GLPv2"
puts

time = Benchmark.measure {

  sample_string = String.new

  # simple math (astoundingly trivial)
  print "Math operations         ->"
  print Benchmark.measure {
    1000000.times {
      a = 1
      b = 2
      c = 3
      d = a * b + c
    }
  }
	
	# complex math
  print "Complex math operations ->"
  print Benchmark.measure {
    1000000.times {
      a = 655
      y = 88
      b = Math.atan2(a, y)
      c = Math.log(a * y)
    }
  }

  # Random operations
  print "Random operations       ->"
  print Benchmark.measure {
    8388608.times {
      sample_string << (65 + rand(26)).chr
    }
  }

  # memory
  print "Memory operations       ->"
  print Benchmark.measure {
    buffer = Array.new
    5000000.times {
      buffer << sample_string
    }
    buffer = nil
  }
	
	# IO
  print "IO operations           ->"
  print Benchmark.measure {
    1000.times {
      File.open("robbench.tmp.txt", "w") { |file|
        file.write(sample_string);
      }
      File.unlink("robbench.tmp.txt")
    }
  }

  # Ruby process creation
  print "Ruby process creation   ->"
  print Benchmark.measure {
    File.open("robbench.tmp.rb", "w") { |file|
      file.write("#!/usr/bin/env ruby\na = 1\nb = 2\nc = 3\nd = a * b + c")
    }
    5000.times {
      system("ruby robbench.tmp.rb")
    }
    File.unlink("robbench.tmp.rb")
  }
}

puts
puts "Total time              ->#{time}"
puts
                                                  
