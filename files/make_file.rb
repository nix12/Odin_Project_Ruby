fname = 'sample.txt'
somefile = File.open(fname, 'w')
somefile.puts 'Hello file'
somefile.close