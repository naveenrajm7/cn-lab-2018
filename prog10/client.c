#include<stdio.h>
#include<sys/socket.h>
#include<arpa/inet.h>

int main(){

    int cliSocket ;
    char buffer[200], host_name[20];
    struct sockaddr_in serAddress, cliAddress;
    socklen_t len;
    
    cliSocket = socket(AF_INET, SOCK_DGRAM, 0);
    
    cliAddress.sin_family = AF_INET;
    cliAddress.sin_port = htons(9000);
    cliAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    bind(cliSocket, (struct sockaddr *) &cliAddress, sizeof(cliAddress));
  
    serAddress.sin_family = AF_INET;
    serAddress.sin_port = htons(8000);
    serAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    printf("enter host name\n");
    scanf("%s",host_name);
    
    len = sizeof(serAddress);
    sendto(cliSocket, host_name, sizeof(host_name), 0, (struct sockaddr *) &serAddress, sizeof(serAddress));
    printf("sent to server: %s", host_name);
    
    recvfrom(cliSocket, buffer, sizeof(buffer), 0, (struct sockaddr *) &serAddress, &len);
    printf("Server says : %s\n", buffer);
}
    
