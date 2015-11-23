# Made with reference of:
# http://stackoverflow.com/questions/15318427/ruby-tcp-server-basics

require 'socket'
require './thread_pool.rb'

ip_address = '134.226.32.10'
port = ARGV[0]
submit_id = "0105a7b6c410f4f3ae2d2acab136fa2744b7b80012e46ff3214ebb93579a1abc"

pool = ThreadPool.new(10)
server = TCPServer.new(ip_address, port)
puts "Listening on #{ip_address}:#{port}"

loop do
  pool.schedule do
    begin
      client = server.accept_nonblock
      puts "Accepted connection"
      message = client.gets(1000)
      puts "Message: " << message
      if message.include? "KILL_SERVICE\n"
        puts "Killing service"
        # Do it in a new thread to prevent deadlock
        Thread.new do
          pool.shutdown
          exit
        end
      elsif message.include? "HELO"
        message.gsub "HELO ", ""
        puts "Giving data dump"
        client.puts message << "IP:#{ip_address}\nPort:#{port.to_s}\nStudentID:#{submit_id}"
      else
        puts "Bollax respsonse"
        client.puts "Go away. This service is for cool people"
      end
      puts "Closing"
      client.close
      puts "Closed"
    rescue
      # Do nothing
    end
  end
end

at_exit { pool.shutdown }