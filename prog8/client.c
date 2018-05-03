#include<stdio.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<stdlib.h>

int main()
{
    int cliSocket, no_of_bytes;
    struct sockaddr_in serAddress;
    char filename[32];
    char buffer[1024];
    cliSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    serAddress.sin_family = AF_INET;
    serAddress.sin_port = htons(7000);
    serAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    if(connect(cliSocket, (struct sockaddr *) &serAddress, sizeof(serAddress))==0)
        printf("conneted to server\n");
    else
    {
        printf("failed to connect\n");
        exit(0);
    }
        
    printf("enter filename to request\n");
    scanf("%s",filename);
    
    send(cliSocket, filename, sizeof(filename), 0);
    
    while((no_of_bytes = recv(cliSocket, buffer, sizeof(buffer), 0)) > 0)
    {
        write(1, buffer, no_of_bytes);
    }     
    close(cliSocket);
       
}    
