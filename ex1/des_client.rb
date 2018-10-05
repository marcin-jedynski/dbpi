require 'openssl'
require 'socket'

cipher = OpenSSL::Cipher.new('des')
cipher.encrypt
key = cipher.random_key
iv = cipher.random_iv
encrypted = cipher.update('elo mordo') + cipher.final
puts(encrypted)

hostname = '150.254.79.106'
port = 2000

s = TCPSocket.open(hostname, port)
s.write(Marshal.dump([key, iv, encrypted]))
s.flush
s.close
