require 'openssl'
require 'socket'

def primitive_root()
    while (true)
        q  = OpenSSL::BN.generate_prime(64)
        p = 2 * q + 1
        if(OpenSSL::BN.new(p).prime?)
            break
        else
            next
        end
    end
    while(true)
        g = rand(2...p-1)
        if( g.to_bn.mod_exp(2.to_bn, p.to_bn).to_i != 1 and g.to_bn.mod_exp(q.to_bn,p.to_bn).to_i != 1)
            return [p,g]
        end
    end
end

p,g = primitive_root()

private_rand = rand(2..p-1)
# alice_public = pow(g, alice_private) % p
client_public = g.to_bn.mod_exp(private_rand.to_bn,p.to_bn)

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
s.write(Marshal.dump([p,g]))
s.write(Marshal.dump([]))

s.write(Marshal.dump([key, iv, encrypted]))
s.flush
s.close
