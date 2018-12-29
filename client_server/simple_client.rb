require 'socket'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)
puts 'opening'
while line = s.gets
	puts line.chop
end
puts 'closing'
s.close