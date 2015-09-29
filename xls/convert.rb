require 'rubygems'
require 'simple_xlsx_reader'

file_to_convert = ARGV[0]

document = SimpleXlsxReader.open(file_to_convert)
file = File.new(file_to_convert + '.converted.txt', 'w')


document.sheets.first.rows.each do |row|
  # it is row string of desired format, which will be writen to file
  string_line = String.new
  # cell counter
  i = 0

  row.each do |f|
    i += 1
    ## opening quote
    string_line << '"'
    ## current cell handler

    ## truncating some floats
    if (f.instance_of?(Float))
      if (i == 2) || (i == 4) || (i == 7) || (i == 12) || (i == 24) || (i == 31)
        f = f.truncate
        # if cell with number - we should add '+' before it
        if (i == 4) || (i == 31)
          f = '+' + f.to_s
        end
      end
    end

    ## fixing dates
    if(f.instance_of?(Date))
      if (i == 5)
        f = f.strftime('%d/%m/%Y')
      end
    end

    ## fixing times
    if(f.instance_of?(Time))
      if (i == 6)
        f = f.strftime('%H:%M:%S')
      end
    end

    ## writing cell value to string line
    string_line << f.to_s

    ## closing quote
    if i == row.size
      string_line << '"'
    else
      string_line << '",'
    end

    ## debug info
   # puts i
   # puts f
   # puts f.class
   # puts '-------------'
  end
  string_line << "\n"
  file.write string_line
end
#puts rows[1]

