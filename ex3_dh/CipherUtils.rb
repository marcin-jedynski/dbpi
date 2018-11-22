require 'openssl'

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