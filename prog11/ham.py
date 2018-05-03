#! /usr/bin/python3

data_word = [int(x) for x in input("Enter 4 bit data word\n")];
code_word = [None]*8;

code_word[3] = data_word[0]
code_word[5] = data_word[1]
code_word[6] = data_word[2]
code_word[7] = data_word[3]

# inserting parity bits
code_word[1] = code_word[3] ^ code_word[5] ^ code_word[7]
code_word[2] = code_word[3] ^ code_word[6] ^ code_word[7]
code_word[4] = code_word[5] ^ code_word[6] ^ code_word[7]

print("generated code word : ", code_word[1:])

print("--"*10)
recv_word =[None]+[int(x) for x in input("Enter recieved code word\n")]
print("received code word",recv_word[1:])

# claculate checksum
c1 = recv_word[1] ^ recv_word[3] ^ recv_word[5] ^ recv_word[7]
c2 = recv_word[2] ^ recv_word[3] ^ recv_word[6] ^ recv_word[7]
c3 = recv_word[4] ^ recv_word[5] ^ recv_word[6] ^ recv_word[7]

checksum = str(c3) + str(c2) + str(c1)
c = int(checksum, 2)

if c == 0:
    print("No error\n")
else:
    print("bit %d is currupted\n"%c)
    recv_word[c] = 0 if recv_word[c] == 1 else 1
print("Correct data ", recv_word[1:])
