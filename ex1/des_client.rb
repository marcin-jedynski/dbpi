require 'openssl'
require 'socket'

cipher = OpenSSL::Cipher.new('des')
puts("Provide your message:")
message = gets()
cipher.encrypt
key = cipher.random_key
iv = cipher.random_iv
encrypted = cipher.update(message) + cipher.final
#puts(encrypted)

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)
s.write(Marshal.dump([key, iv, encrypted]))
s.flush
s.close
