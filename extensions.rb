require 'date'

class String
  # is_date? :: void -> bool
  def is_date?
    self.match(/^[0-9]{4}(-[0-9]{2}){2}$/)
  end

  # is_file? :: void -> bool
  def is_file?
    path = self.to_abs_path
    ((File.exist?(path)) &&
     (File.readable?(path)))
  end

  # is_numeric? :: void -> bool
  def is_numeric?
    self.match(/^[0-9]+$/)
  end

  # to_abs_path :: void -> string
  def to_abs_path
    File.expand_path(self)
  end

  # to_timestamp :: string? -> int
  def to_timestamp(time = '00:00')
    DateTime.parse([self, time].join(' ')).to_time.to_i
  end
end
