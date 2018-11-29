require 'socket'
require 'openssl'

decipher = OpenSSL::Cipher.new('des')
decipher.decrypt


server = TCPServer.open(2000)
loop{
 
  client = server.accept
  puts("client connection:")
  puts client

  client_key = File.read('pub_key.txt')
  dsa = OpenSSL::PKey::DSA.new(client_key)

  parameters = Marshal.load(client.gets)
  signature = parameters[0]
  hash = OpenSSL::Digest::SHA256.digest(parameters[1])
  puts "signature:"
  puts signature
  puts "hash:"
  puts hash
  puts "Is signature veryfied: " + "#{dsa.sysverify(hash, signature)}"
  parameters = Marshal.load(parameters[1])

  p = OpenSSL::BN.new(parameters[1])
  g = OpenSSL::BN.new(parameters[2])
  client_public = OpenSSL::BN.new(parameters[3])
  private_rand = OpenSSL::BN.new(rand(2..p-1))
  server_public = g.mod_exp(private_rand,p)

  client.puts(Marshal.dump(server_public.to_s))

  secret = client_public.mod_exp(private_rand,p) 
  client.flush
  ciphertext = Marshal.load(client.gets)
  iv = ciphertext[0]
  message = ciphertext[1]
  decipher.key = secret.to_s.bytes[0..7].pack("c*")
  decipher.iv = iv
  puts("message encrypted:")
  puts(message)
  puts("message decrypted")
  puts(decipher.update(message) + decipher.final)
  client.close
}