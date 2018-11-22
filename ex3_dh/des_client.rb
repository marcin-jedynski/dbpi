require 'openssl'
require 'socket'

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
# test = Marshal.dump(["msg" => "INIT","PRIME" => p.to_i,"GEN" => g.to_i,"CLIENT_PUB" => client_public.to_i ])
# puts test
##send p,g,client_public
hostname = 'localhost'
port = 2000
puts p,g
s = TCPSocket.open(hostname, port)
s.puts(Marshal.dump(["INIT",p.to_s, g.to_s, client_public.to_s ]))
s.flush
server_public = Marshal.load(s.gets)
puts server_public


# cipher = OpenSSL::Cipher.new('des')
# puts("Provide your message:")
# message = gets()
# cipher.encrypt
# key = cipher.random_key
# iv = cipher.random_iv
# encrypted = cipher.update(message) + cipher.final
# #puts(encrypted)



# s = TCPSocket.open(hostname, port)
# s.write(Marshal.dump([p,g]))
# s.write(Marshal.dump([key, iv, encrypted]))
# s.flush
s.close
