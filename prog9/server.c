#include<stdio.h>
#include<fcntl.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/stat.h>

int main()
{
    int fd, rdf, wrf, no_of_bytes ;
    char filename[32], buffer[1024];
    
    mkfifo("fifo1",0600);
    mkfifo("fifo2",0600);
    
    rdf = open("fifo1",O_RDONLY);
    wrf = open("fifo2",O_WRONLY);
    
    read(rdf, filename, sizeof(filename));
    printf("Client requested :%s",filename);
    
    fd = open(filename, O_RDONLY);
    if(fd == -1)
        write(wrf, "File Not Found\n",15);
    else
    {
        while((no_of_bytes=read(fd,buffer,1024)) > 0)
        {
            write(wrf, buffer, no_of_bytes);
        }
    }
    
    unlink("fifo1");
}
  
    
