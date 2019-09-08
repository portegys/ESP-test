string myname = "title";
integer mychannel = -1;
vector text_color = <0,1,0>;

default
{
    state_entry()
    {
        llSetText("", text_color, 1.0);    
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

        if (message == "clear")
        {
            llSetText("", text_color, 1.0);
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
                llSetText(command, text_color, 1.0);
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
