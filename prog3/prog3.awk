BEGIN{
drop=0;
}
{
    if($1 == "d")
    {
        drop++;
    }
}
END{
printf("The number of %d packets dropped =%d\n", $5, drop);
}
