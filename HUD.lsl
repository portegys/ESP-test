string myname = "HUD";
integer common_channel = -4517;
integer mychannel = -1;

default
{
    state_entry()
    {
        llListen(common_channel, "", NULL_KEY, "");
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list command_list = [];
                
        // Only listen when attached.
        if (llGetAttached())
        {
            // Channel assignment message?
            if (channel == common_channel)
            {
                command_list = llParseString2List(message, [";"], []);
                if (llGetListLength(command_list) == 2)
                {
                    if (llList2Key(command_list, 1) == llGetOwner())
                    {
                        // Distribute assigned channel to components.
                        mychannel = (integer)llList2String(command_list, 0);
                        llListen(mychannel, "", NULL_KEY, "");
                        llMessageLinked(LINK_ALL_OTHERS, mychannel, "channel", NULL_KEY);
                        llMessageLinked(LINK_ALL_OTHERS, 0, "reset", NULL_KEY);
                        
                        // Indicate ready.
                        llSay(mychannel, "ready;" + (string)llGetOwner());
                    }
                }
                return;
            }
    
            // Command?
            if (channel == mychannel && mychannel != -1)
            {
                // Get target and command.
                command_list = llParseString2List(message, [";"], []);
                if (llGetListLength(command_list) != 3) return;
                string target = llList2String(command_list, 0);
                string command = llList2String(command_list, 1);
                key avatar = (key)llList2String(command_list, 2);
                
                // Command for me?
                if (target == myname && avatar == llGetOwner())
                {
                    if (command == "clear")
                    {
                        llMessageLinked(LINK_ALL_OTHERS, 0, "reset", NULL_KEY);
                        return;
                    }
                    if (command == "reset")
                    {
                        mychannel = -1;
                        llMessageLinked(LINK_ALL_OTHERS, -1, "channel", NULL_KEY);
                        llMessageLinked(LINK_ALL_OTHERS, 0, "reset", NULL_KEY);
                        return;
                    }                    
                }
                return;
            }
        }
    }

    attach(key id)
    {
        if(id)
        {
            // Request a channel on attach.
            llSay(common_channel, "channel_request;" + (string)llGetOwner());
        } else {
            // Reset on detach.
            if (mychannel != -1)
            {
                llSay(mychannel, "detach;" + (string)llGetOwner());
            }
            mychannel = -1;
            llMessageLinked(LINK_ALL_OTHERS, -1, "channel", NULL_KEY);
            llMessageLinked(LINK_ALL_OTHERS, 0, "reset", NULL_KEY);
        }
    }

    changed(integer mask)
    {
        if(mask & CHANGED_OWNER)
        {
            llResetScript();
        }
    }                
}
