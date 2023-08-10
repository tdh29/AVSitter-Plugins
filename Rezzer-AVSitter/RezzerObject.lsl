
default
{
    state_entry()
    {
        
    }
    
    listen(integer CH, string name, key id, string message)
    {
        if (message=="DIEDIEDIE")
        {
            llDie();
        }
    }
    
    on_rez(integer start_param)
    {
        llListen(start_param,"","","DIEDIEDIE");
        llWhisper(start_param,"DIEDIEDIE");//Deletes another instance already rezzed to avoid clutter/ object spam
    }
}
