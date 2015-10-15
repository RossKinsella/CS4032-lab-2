require 'socket'
require 'thread'

threads = []

successes = 0
rejections = 0

2000.times do |i|
  threads << Thread.new do
    begin 
      puts "Thread #{i} is requesting a socket"
      socket = TCPSocket.open('127.0.0.1', 3000)
      puts "Thread #{i} has connected to a socket"
      socket.puts "HELO text\n"
      respsone = socket.recv(1000)
      puts "Got '#{respsone.gsub "\n", ""}' from #{i}"
      successes += 1
      socket.close
      puts "Thread #{i} has closed its connection"
    rescue
      puts "Could not establish a socket connection for t: #{i}"
      rejections += 1
    end
  end
end

threads.each { |thr| thr.join }

socket = TCPSocket.open('127.0.0.1', 3000)
socket.puts "KILL_SERVICE\n"
socket.close

puts "Successes: #{successes.to_s}"
puts "Rejections: #{rejections.to_s}"