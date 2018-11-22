require 'socket'
require 'openssl'

decipher = OpenSSL::Cipher.new('des')
decipher.decrypt

server = TCPServer.open(2000)
loop{

  client = server.accept
  puts client
  # array = Marshal.load(client.read)
  # key, iv, message = array
  parameters = Marshal.load(client.gets)
  puts parameters[0]
  p = OpenSSL::BN.new(parameters[1])
  g = OpenSSL::BN.new(parameters[2])
  client_public = OpenSSL::BN.new(parameters[3])
  private_rand = OpenSSL::BN.new(rand(2..p-1))
  server_public = g.mod_exp(private_rand,p)
  puts server_public
  client.puts(Marshal.dump(server_public.to_s))
  
  # client.flush


  # #puts(key, iv, message)
  # decipher.key = key
  # decipher.iv = iv
  # puts(decipher.update(message) + decipher.final)
  client.close
}