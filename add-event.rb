#!/usr/bin/env ruby

require_relative 'requirements.rb'

# configure :: [string]? => conf?
# conf = {
#   :date => string?
#   :text => string?
#   :help => bool
# }
def configure(args = [ ])
  conf = {
    :date => nil,
    :text => nil,
    :help => false,
  }

  if ((args.nil?) || (args.empty?))
    conf[:help] = true
    return conf
  end

  conf[:date] = Date.today.strftime('%Y-%m-%d')

  n = 0
  max = args.length
  check_arg = ->(arg, key) {
    if ((n + 1) < max)
      n += 1
      conf[key] = args[n]
      return true
    else
      return false
    end
  }

  while (n < max)
    arg = args[n]
    if (arg[0] == '-')
      arg = arg.downcase
      # The presence of a `help` argument supersedes all others.
      if ((arg == '-h') || (arg == '--help'))
        conf[:date] = nil
        conf[:text] = nil
        conf[:help] = true
        n = max
      elsif ((arg == '-d') || (arg == '--date'))
        if (!check_arg.call(arg, :date))
          $stderr.puts "Argument '#{arg}' requires a value. Form: #{arg} DATE"
          return nil
        end
      elsif ((arg == '-t') || (arg == '--title'))
        if (!check_arg.call(arg, :text))
          $stderr.puts "Argument '#{arg}' requires a value. Form: #{arg} TITLE"
          return nil
        end
      else
        $stderr.puts "Invalid argument '#{arg}'"
      end
    end
    n += 1
  end
  return conf
end

# handle :: conf? ->  while (n < max)
# conf = see `configure`
def handle(conf = nil)
  if (conf.nil?)
    return nil
  end

  if (conf[:help])
    puts "HELP IS ON THE WAY"
    return nil
  end

  if ((!conf[:date].nil?) &&
      (!conf[:text].nil?))
    file = File.open(default_file, 'a+')
    stream = EventStream.new(file)
    add = true
    while (event = stream.next!)
      if ((event[:date] == conf[:date]) &&
          (event[:text] == conf[:text]))
        add = false
        break
      end
    end
    if (add)
      add_to_file(file, {:date => conf[:date], :text => conf[:text]})
    else
      $stderr.puts "Event already exists in calendar #{default_file}."
    end
    file.close
  end
end

# default_file :: void -> string
def default_file
  #"#{File.expand_path('~')}/.calendar/calendar-events"
  "#{__dir__}/test-data"
end

# add_to_file :: (IO, event) -> bool
# event = see EventStream.next!
def add_to_file(file, event)
  file.puts(''.concat(event[:date])
              .concat("\t")
              .concat(event[:text]))
end

# This runs it.
handle(configure(ARGV))
