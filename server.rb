# Made with reference of:
# http://stackoverflow.com/questions/15318427/ruby-tcp-server-basics

require 'socket'
require './thread_pool.rb'

ip_address = '127.0.0.1'
port = ARGV[0]
submit_id = "0105a7b6c410f4f3ae2d2acab136fa2744b7b80012e46ff3214ebb93579a1abc"

pool = ThreadPool.new(10)
server = TCPServer.new(ip_address, port)
puts "Listening on 127.0.0.1:#{port}"

loop do
  pool.schedule do
    begin
      client = server.accept_nonblock
      message = client.gets(1000)
      
      if message == "KILL_SERVICE\n"
        # Do it in a new thread to prevent deadlock
        Thread.new do
          pool.shutdown
          exit
        end
      elsif message == "HELO text\n"
        client.puts "HELO text\nIP:#{ip_address}\nPort:#{port.to_s}\nStudentID:#{submit_id}\n"
      end

      client.close
    rescue
      # Do nothing
    end
  end
end

at_exit { pool.shutdown }