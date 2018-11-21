require 'socket'
require 'openssl'

decipher = OpenSSL::Cipher.new('des')
decipher.decrypt

server = TCPServer.open(2000)
loop{

  client = server.accept
  # array = Marshal.load(client.read)
  # key, iv, message = array
  parameters = Marshal.load(client.read)
  p ,g = parameters
  private_rand = rand(2..p-1)
  server_public = g.to_bn.mod_exp(private_rand.to_bn,p.to_bn)


  #puts(key, iv, message)
  decipher.key = key
  decipher.iv = iv
  puts(decipher.update(message) + decipher.final)
  client.close
}