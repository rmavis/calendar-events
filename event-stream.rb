require 'date'

class EventStream
  # EventStream.new :: IO -> EventStream
  def initialize(file)
    # self.file :: IO
    @file = file
    # self.buffer :: string?
    @buffer = nil
  end

  attr_reader :file
  attr_accessor :buffer

  # next! :: void -> event?
  # event = {
  #   :timestamp => DateTime?
  #   :date => string?
  #   :text => string?
  # }
  # next! only returns the event, not an indication that more entries
  # can be read. So while reading, it could reach the EOF and return
  # an event comprising data gathered while reading, and a subsequent
  # call to next! will also reach EOF and next! will return nil. So
  # there's an redundant call to read_line. That can be fixed. TODO
  def next!
    event = {
      :timestamp => nil,
      :date => nil,
      :text => nil,
    }

    while
      line = self.read_line
      if (line.nil?)
        break
      end
      if (parts = line.match(/^(([0-9]{4}-[0-9]{2}-[0-9]{2})( [0-9]{2}:[0-9]{2})?)(\t(.*))?$/))
        if (event[:date].nil?)
          if (parts[3].nil?)
            event[:timestamp] = DateTime.parse("#{parts[2]} 00:00").to_time.to_i
          else
            event[:timestamp] = DateTime.parse(parts[1]).to_time.to_i
          end
          event[:date] = parts[1]
          event[:text] = parts[5]
          self.buffer = nil
        else
          self.buffer = line
          break
        end
      elsif ((!event[:date].nil?) &&
             (line[0] == "\t") &&
             (!line.strip.empty?))
        if ((event[:text].nil?) ||
            (event[:text].empty?))
          event[:text] = line.strip
        else
          event[:text] += " " + line.strip
        end
      else
        #$stderr.puts "dtgrep: skipping line '#{line}'."
      end
    end

    if ((event[:date].nil?) ||
        (event[:text].nil?))
      return nil
    end
    return event
  end

  # read_line :: void -> string?
  def read_line
    if (!self.buffer.nil?)
      return self.buffer
    end
    begin
      return self.file.readline.chomp
    rescue EOFError
      #$stderr.puts "dtgrep: reached EOF"
      return nil
    end
  end
end
