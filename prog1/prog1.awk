BEGIN{
drop=0;
recv=0;
}
{
    if($1 == "d")
    {
        drop++;
    }
    else if($1 == "r")
    {
        recv++;
    }
}
END{
printf("The number of packets dropped =%d\n",drop);
printf("The number of packets recevied = %d\n",recv);
}
