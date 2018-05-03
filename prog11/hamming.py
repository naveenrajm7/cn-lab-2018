#! /usr/bin/python3
def xOr(alist):
        ''' return XOR of all elements in list'''
        xor =0
        if len(alist)> 0:
                xor = alist[0]
                for i in range(1,len(alist)):
                        xor = xor ^ alist[i]

        return xor

if __name__ == "__main__":
        ''' Hamming code : detects 2 bit error but corrects 1 bit error
            Hamming code implementation of F(7,4)       '''
        data_word = [int(x) for x in input("Enter 4 bit data word\n")]

        code_word = [None]*(len(data_word)+3+1) # 1 indexed list

        for i in range(3):      # inserting parity bits in positions 2^n , for n= 0,1,2,
                code_word[2**i] ='p'+str(i)

        for i in range(7,0,-1): # insering data word in remaining position
                if code_word[i] == None:
                        code_word[i] = data_word.pop()

        print("code word to be built:",code_word[1:])
        print("         ** where p0,p1,p2 are parity bits")
        # parity bits equations
        p0 = []
        p1 = []
        p2 = []
        for i in range(1,8):
                if code_word[i] == 1 or code_word[i] == 0:
                        index = bin(i)
                        if index[-1] == '1':
                                p0.append(code_word[i])
                        if index[-2] == '1':
                                p1.append(code_word[i])
                        if index[-3] == '1':
                                p2.append(code_word[i])

        print("parity bits:","p0 = XOR of",p0,"p1 = XOR of",p1,"p2 = XOR of",p2)

        #replacing p by xor of equations
        for i in range(1,8):
                if code_word[i] == 'p0':
                        code_word[i] = xOr(p0)
                if code_word[i] == 'p1':  
                        code_word[i] = xOr(p1)
                if code_word[i] == 'p2':
                        code_word[i] = xOr(p2)
        codegen = code_word[1:]
        print("generated code word",codegen)
        print("--"*10)
        code_word =[None]+[int(x) for x in input("Enter recieved code word\n")]
        print("received code word",code_word[1:])
        # q bits equations
        q0 = []
        q1 = []
        q2 = []
        for i in range(1,8):
                if code_word[i] == 1 or code_word[i] == 0:
                        index = bin(i)
                        if index[-1] == '1':
                                q0.append(code_word[i])
                        if index[-2] == '1':
                                q1.append(code_word[i])
                        if index[-3] == '1':
                                q2.append(code_word[i])
        print("q equation bits:",q0,q1,q2)
        checker =  str(xOr(q2)) +str( xOr(q1))+ str(xOr(q0))
        print("checker bits:",checker)
        pos = int(checker,2) # coverting binary string 'checker' to decimal
        if pos == 0:
                print("No error occured[SUCCESS]")
        else:
                print("Bit number %d is currupted [DETECTION]"%(pos))
                if code_word[pos] == 0:
                        print("change bit %d from %d -> %d [CORRECTION]"%(pos,0,1))
                        code_word[pos] = 1
                else:
                        print("change bit %d from %d -> %d [CORRECTION]"%(pos,1,0))
                        code_word[pos] = 0
        print(code_word[1:])
