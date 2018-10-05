require 'socket'
require 'openssl'

decipher = OpenSSL::Cipher.new('des')
decipher.decrypt

server = TCPServer.open(2000)
loop{
  client = server.accept
  array = Marshal.load(client.gets)
  key, iv, message = array
  puts(key, iv, message)
  decipher.key = key
  decipher.iv = iv
  puts(decipher.update(message) + decipher.final)
  client.close
}