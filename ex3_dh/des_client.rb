require 'openssl'
require 'socket'

hostname = 'localhost'
port = 2000
dsa = OpenSSL::PKey::DSA.new(2048)
File.open('pub_key.txt', 'w') { |file| file.write(dsa.public_key.to_der) }
# puts dsa.params

def primitive_root()
    while (true)
        q = OpenSSL::BN.generate_prime(64)
        p = OpenSSL::BN.new(2 * q + 1)
        if(p.prime?)
            break
        else
            next
        end
    end
    while(true)
        g = rand(2...p-1).to_bn
        if( g.mod_exp(2.to_bn, p).to_i != 1 and g.mod_exp(q,p).to_i != 1)
            return [p,g]
        end
    end
end

p,g = primitive_root()

#generate private rand
private_rand = OpenSSL::BN.new(rand(2..p-1))

#generate public key
client_public = g.mod_exp(private_rand,p)
##send p,g,client_public

s = TCPSocket.open(hostname, port)

params = Marshal.dump(["INIT",p.to_s, g.to_s, client_public.to_s])
hash = OpenSSL::Digest::SHA256.digest(params)
signed = dsa.syssign(hash)
puts "signature:"
puts signed
puts "hash:"
puts hash
s.puts(Marshal.dump([signed, params]))
s.flush
server_public = OpenSSL::BN.new(Marshal.load(s.gets))
secret = server_public.mod_exp(private_rand,p) 

cipher = OpenSSL::Cipher.new('des')
puts("Provide your message:")
message = gets()

cipher.encrypt
cipher.key = secret.to_s.bytes[0..7].pack("c*")
iv = cipher.random_iv
encrypted = cipher.update(message) + cipher.final
puts("message encrypted")
puts(encrypted)
s.flush
s.puts(Marshal.dump([iv, encrypted]))
s.flush
s.close
