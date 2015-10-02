require 'rubygems'

filename = ARGV[0]
if File.exist? filename
  file    = File.new(filename, 'a+')
else
  file    = File.new(filename, 'w+')
end
file2   = File.open('test.txt', 'r')
content = File.readlines(file2)

file.write(content[2])
file.write(content[3])
#file.flush
file.fsync
if File.readable?(file)
  puts 'In new file:'
  cont2 = File.read(file)
  puts cont2
end

