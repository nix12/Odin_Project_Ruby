require 'socket'
require 'json'

host = 'localhost'
port = 2000
path = '/index.html'


p 'Will this be a POST or GET request?'
action = gets.chomp.upcase
params = {}

if action == 'GET'
	puts 'In GET'
	request = "GET #{ path } HTTP/1.0\r\n\r\n"
elsif action == 'POST'
	p 'Please enter name'
	name = gets.chomp

	p 'Please enter email'
	email = gets.chomp

	params = { viking: { name: name, email: email } }
	body = params.to_json

	request = "POST /thanks.html HTTP/1.0\nContent-Length: #{body.length}\r\n\r\n#{body}"
else
	puts 'Error! No such action'
end

socket = TCPSocket.open(host, port)
socket.print(request)

response = socket.read

headers, body = response.split("\r\n\r\n", 2)
print body

socket.close