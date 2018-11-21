# require 'openssl'
# require 'socket'

# cipher = OpenSSL::Cipher.new('des')
# puts("Provide your message:")
# message = gets()
# cipher.encrypt
# key = cipher.random_key
# iv = cipher.random_iv
# encrypted = cipher.update(message) + cipher.final
# #puts(encrypted)

# hostname = 'localhost'
# port = 2000

# s = TCPSocket.open(hostname, port)
# s.write(Marshal.dump([key, iv, encrypted]))
# s.flush
# s.close

from Cryptodome.Cipher import DES
import random
import socket
import sys


plaintext = input("podaj wiadomosc\n")
#k = ...
#cipher = DES.new(key, DES.MODE_CBC)
#msg = cipher.iv + cipher.encrypt(plaintext)

hotstname = 'localhost'
port = 2222

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((hotstname,port))
s.send(plaintext)







