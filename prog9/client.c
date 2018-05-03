#include<stdio.h>
#include<fcntl.h>
#include<stdlib.h>
#include<unistd.h>

int main()
{
    int rdf, wrf, no_of_bytes ;
    char filename[32], buffer[1024];
  
    wrf = open("fifo1",O_WRONLY);
    rdf = open("fifo2",O_RDONLY);
    
    printf("Enter the file to request:\n");
    scanf("%s",filename);
    
    write(wrf, filename, sizeof(filename));
    
    printf("server :\n");
    
        while((no_of_bytes=read(rdf,buffer,1024)) > 0)
        {
            write(1, buffer, no_of_bytes);
        }
    
    unlink("fifo2");
}
  
    
