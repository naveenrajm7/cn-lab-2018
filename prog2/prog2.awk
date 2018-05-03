BEGIN{
tcp = 0;
udp = 0;
}
{
    if($1 == "r" && $5 == "tcp")
    {
        tcp++;
    }
    else if($1 == "r" && $5 == "cbr")
    {
        udp++;
    }
}
END{
    printf("No. of packets sent by TCP(n0-n3) : %d\n",tcp);
    printf("No. of packtes sent by UDP(n1-n3) : %d\n",udp);
}
