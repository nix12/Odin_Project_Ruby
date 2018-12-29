require 'socket'
require 'json'

server = TCPServer.open(2000)
loop {
	client = server.accept
	client.puts(Time.now.ctime)
	
		header_info = client.gets.split(' ')

		puts header_info
		filename = header_info[1].to_s.gsub!('/', '')

	if header_info[0] == 'GET'
		if File.exists?(filename)
			f = File.open(filename, 'r')
			file = ""
			file << f.read
			client.puts "#{ header_info[2] } 200 success"
			client.puts "Content-Length: #{ file.length }"
			
			client.puts file
		else
			client.puts "#{ header_info[2] } 404 file not found"
		end
		
	elsif header_info[0] == 'POST'
		client.puts header_info
	end

	client.puts 'Closing the connection. Bye!'
	client.close
}