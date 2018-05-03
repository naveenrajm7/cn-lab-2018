#! /usr/bin/python3
''' Program to detect error in using Cyclic Redundant Codes '''

def xor(a, b):
    ''' returns XOR of two list only if two list or of equal size else None '''
    if len(a)==len(b):
        return [a[i]^b[i] for i in range(len(a))]

        
def genChecksum(divident, divisor):
    ''' generates check sum(reminder) & returns it for given data_word(divident) & and generator(divisor)
     by performing division '''
     
    div_len = len(divisor)
    data_len = len(divident)
    
    reminder = []
    quotient = []
    
    # divisor will always starts with 1 , so
    # taking first divisor length bits of data_word as reminder
    reminder = divident[:div_len]
    
    # Total number of division is  no. of data bits - divisor bits + 1                
    for i in range(data_len-div_len+1):
        if reminder[0] != 0:             #if first bit is 1 , add 1 to quotient & XOR with divisor
            quotient.append(1)     
            reminder = xor(reminder,divisor)
        else :                             #if first bit is 0 , add 0 to quotient & XOR with 0*divisor
            quotient.append(0)
            reminder = xor(reminder, [0]*div_len)
                
        del reminder[0]
        #Don't attempt to fetch data bit for last division
        if i != data_len-div_len :
            reminder.append(divident[div_len+i])
                   
    return reminder
    
if __name__ == "__main__" :
    
    data_word = input("Enter the dataword\n")
    generator = input("Enter the commom generator(divisor)\n")
    
    data_word = [int(x) for x in data_word]
    generator = [int(x) for x in generator]
    # agumenting (gen_len-1) 0's for data_word
    data_agu = data_word[:]
    data_agu.extend(0 for _ in range(len(generator)-1))
    
    code_word = data_word[:]
    code_word.extend(genChecksum(data_agu, generator))
    
    print("\ndata word:"+"".join(str(data_word))+"\ngenerator:"+"".join(str(generator)))
    print("generating code word"+"."*10)
    print("\ncode word:"+"".join(str(code_word)))
    
    print("Unreliable transmission\n"+"-"*10)
    
    code_word = [int(x) for x in input("Enter code word \n")]
    
    reminder = genChecksum(code_word, generator)
    
    if 1 in reminder:
        print("error occured in transmission\n")
    else :
        print("no error \n")
