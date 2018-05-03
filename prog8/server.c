#include<stdio.h>
#include<sys/socket.h>
#include<string.h>
#include<arpa/inet.h>
#include<fcntl.h>
#include<unistd.h>
#include<stdlib.h>
#include<netinet/in.h>


int main()
{
    int serSocket, cliSocket, fd, no_of_bytes;
    struct sockaddr_in serAddress, cliAddress;
    socklen_t len;
    char buffer[1024];
    char filename[32];
    
    serSocket = socket(AF_INET, SOCK_STREAM, 0);
    if(serSocket == -1)
    {
        printf("Error\n");
        exit(0);
    }
    else
    {
        printf("Socket created\n");
    }    
    serAddress.sin_family = AF_INET;
    serAddress.sin_port = htons(7000);
    serAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    if(bind(serSocket,(struct sockaddr *) &serAddress, sizeof(serAddress))==0)
    {
        printf("binded\n");
    }
    
    if(listen(serSocket, 5) != 0)
        printf("error\n");
    else
        printf("listening\n");
        
    len = sizeof(cliAddress);
    cliSocket = accept(serSocket,(struct sockaddr *)&cliAddress, &len);
    
    recv(cliSocket, filename, sizeof(filename), 0);
    
    fd = open(filename, O_RDONLY);
    if(fd == -1)
    {
        send(cliSocket, "file Not Found\n", 15, 0);
    }
    else
    {
        send(cliSocket, "file Contents are:\n", 19, 0);
        while((no_of_bytes = read(fd, buffer, sizeof(buffer))) > 0)
        {
            send(cliSocket, buffer, no_of_bytes, 0);
        }
    }    
    close(cliSocket);
}               
     
