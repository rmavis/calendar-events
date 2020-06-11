require 'date'
require_relative 'extensions.rb'
{
  :EventStream => 'event-stream.rb',
}.each do |sym,file|
  autoload(sym, "#{__dir__}/#{file}")
end
