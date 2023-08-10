integer listener;
integer CHANNEL;

list textures =
[
"Object1a", "UUID1", "UUID2", 
"Object1b", "UUID1", "UUID2", 
"Object1c", "UUID1", "UUID2", 
"Object2a", "UUID1", "UUID2",
"Object2b", "UUID1", "UUID2",
"Object2c", "UUID1", "UUID2",
"Object3a", "UUID1", "UUID2",
"Object3b", "UUID1", "UUID2",
"Object3c", "UUID1", "UUID2"
];

list options;


set_texture(string test)
{
    integer x = llListFindList(textures,[test]);//find the names position in the list
    string texture1 = llList2String(textures,x+1);//Set corresponding UUID
    string texture2 = llList2String(textures,x+2);//Set corresponding UUID
    llSetLinkPrimitiveParamsFast(LINK_THIS,[PRIM_TEXTURE,0,texture1,<1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0, 
    PRIM_TEXTURE,1,texture2,<1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0]);
}

start_listener(key toucher)
{
    llListenRemove(listener);//Clear up before we start
    CHANNEL = (integer)llFrand(-6000-(-900000));//make a random channel
    listener = llListen(CHANNEL,"",toucher,"");//Set the listener
}

stop_listener()
{
    llListenRemove(listener);//remove the listener
}

 
get_options()
{
    integer x;//We temporarily use this integer for counting
    //Now we go through the texture list and add the names to a new list
    for(x=0;x<llGetListLength(textures);x+=3)
    {
        string temp = llList2String(textures,x);
        if(llSubStringIndex(temp,llGetObjectName())!=-1)
        {
            options += llList2String(textures,x);
        }
    }
}

default
{
    state_entry()
    {
        get_options();
    }
    
    touch_start(integer total_number)
    {
        key toucher = llDetectedKey(0);
        start_listener(toucher);//start listening
        llDialog(toucher,"Please select a texture option",options,CHANNEL);
    }
    
    listen(integer CH, string name, key id, string message)
    {
        stop_listener();//always close the listener
        if(llListFindList(textures,[message])!=-1)
        {
            set_texture(message);//Set the texture according to what was selected
        }
        else if (message=="DIEDIEDIE")
        {
            llDie();
        }
    }
    
    on_rez(integer start_param)
    {
        llListen(start_param,"","","DIEDIEDIE");
        llWhisper(start_param,"DIEDIEDIE");
    }
    
    timer()
    {
        stop_listener();//stop listener just in case it is still on
    }
}
