string myname = "circle_card";
integer mychannel = -1;

default
{
    state_entry()
    {  
    }
 
    link_message(integer sender_num, integer num, string message, key id)
    {
        if (message == "channel")
        {
            // Listen on assigned channel.
            mychannel = num;
            llListen(mychannel, "", NULL_KEY, "");
            return;
        }

        if (message == "reset")
        {
            return;
        }
    }    

    listen(integer channel, string name, key id, string message)
    {
        if (llGetAttached() && channel == mychannel && mychannel != -1)
        {
            // Get target and command.
            list command_list = llParseString2List(message, [";"], []);
            if (llGetListLength(command_list) != 3) return;
            string target = llList2String(command_list, 0);
            string command = llList2String(command_list, 1);
            key avatar = (key)llList2String(command_list, 2);
            
            // Command for me?
            if (target == myname && avatar == llGetOwner())
            {
            }
        }    
    }

    touch_start(integer count)
    {
        if (llGetAttached() && mychannel != -1)
        {
            // Send touch event.
            llSay(mychannel, myname + ";" + (string)llGetOwner());
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
