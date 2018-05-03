#include<stdio.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<netdb.h>
#include<string.h>

//char* local_lookup(char * buf);

struct dns {
    char name[50];
    char addr[50];
 }addr[10] ={
    { "www.zebra.com" , "213.213.213.213"},
    { "www.xvideos.com" , "000.000.000.000"},
    { "www.cute213.com", "923.312.311.232"}
    };

char* local_lookup(char* buf)
{
    int i ;
    for (i = 0 ; i<4; i++)
    {
        if (strcmp(buf, addr[i].name)==0){
           return addr[i].addr ;
        }
    }
    return "NOt found";
}

int main(){

    int serSocket, cliSocket ;
    char buffer[100];
    struct sockaddr_in serAddress, cliAddress;
    socklen_t len;
    
    serSocket = socket(AF_INET, SOCK_DGRAM, 0);
    
    serAddress.sin_family = AF_INET;
    serAddress.sin_port = htons(8000);
    serAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    bind(serSocket, (struct sockaddr *) &serAddress, sizeof(serAddress));
    
    cliAddress.sin_family = AF_INET;
    cliAddress.sin_port = htons(9000);
    cliAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    len = sizeof(cliAddress);
    
    recvfrom(serSocket, buffer, sizeof(buffer), 0, (struct sockaddr *) &cliAddress, &len);
    
    printf("%s",buffer);
    strcpy(buffer, local_lookup(buffer));
    /*struct hostent *hp = gethostbyname(buffer);

 if (hp == NULL) {
   strcpy(buffer,"gethostbyname() failed\n");

 } else {
   //printf("%s = ", hp->h_name);
   unsigned int i=0;
   while ( hp -> h_addr_list[i] != NULL) {
     strcpy(buffer, inet_ntoa( *( struct in_addr*)( hp -> h_addr_list[i])));
     i++;
   }
 }*/
 
    sendto(serSocket, buffer, sizeof(buffer) , 0, (struct sockaddr *) &cliAddress, sizeof(cliAddress));
        
}
    
