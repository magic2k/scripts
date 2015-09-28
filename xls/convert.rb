require 'rubygems'
require 'simple_xlsx_reader'

#document = SimpleXlsxReader.open('./gamma1.xlsx')
document = SimpleXlsxReader.open('./gamma_sample.xlsx')

puts document.sheets.first.rows.inspect


