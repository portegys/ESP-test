// ESP table.
// Uses Zener cards to provide simultaneous clairvoyance tests or a single 
// telepathy test involving two subjects.

// Communication channels.
integer common_channel = -4517;
integer channel1 = -4518;
integer channel2 = -4519;

// Subject states.
integer IDLE_STATE = 0;
integer PRESENT_STATE = 1;
integer READY_STATE = 2;
integer RENDEZVOUS_STATE = 3;
integer TESTING_STATE = 4;

// Subject roles.
integer NULL_ROLE = 0;
integer CLAIRVOYANCE_ROLE = 1;
integer TELEPATH_SEND_ROLE = 2;
integer TELEPATH_RECEIVE_ROLE = 3;

// Status.
key subject1 = NULL_KEY;
key subject2 = NULL_KEY;
integer role1 = NULL_ROLE;
integer role2 = NULL_ROLE;
integer state1 = IDLE_STATE;
integer state2 = IDLE_STATE;
integer test_card1 = -1;
integer test_card2 = -1;
integer trial1 = 0;
integer trial2 = 0;
integer correct1 = 0;
integer correct2 = 0;
integer card_pick = -1;

// Card types.
integer circle_card = 0;
integer cross_card = 1;
integer square_card = 2;
integer star_card = 3;
integer waves_card = 4;
integer question_card = 5;

// Show test card value.
show_card(integer subject, integer card_num)
{
    if (subject == 1)
    {
      if (card_num == circle_card)
      {
          llSay(channel1, "test_card;circle;" + (string)subject1);
          return;
      }
      if (card_num == cross_card)
      {
          llSay(channel1, "test_card;cross;" + (string)subject1);
          return;
      }
      if (card_num == square_card)
      {
          llSay(channel1, "test_card;square;" + (string)subject1);
          return;
      }
      if (card_num == star_card)
      {
          llSay(channel1, "test_card;star;" + (string)subject1);
          return;
      }
      if (card_num == waves_card)
      {
          llSay(channel1, "test_card;waves;" + (string)subject1);
          return;
      }
      if (card_num == question_card)
      {
          llSay(channel1, "test_card;question;" + (string)subject1);
          return;
      }
    } else {
      if (card_num == circle_card)
      {
          llSay(channel2, "test_card;circle;" + (string)subject2);
          return;
      }
      if (card_num == cross_card)
      {
          llSay(channel2, "test_card;cross;" + (string)subject2);
          return;
      }
      if (card_num == square_card)
      {
          llSay(channel2, "test_card;square;" + (string)subject2);
          return;
      }
      if (card_num == star_card)
      {
          llSay(channel2, "test_card;star;" + (string)subject2);
          return;
      }
      if (card_num == waves_card)
      {
          llSay(channel2, "test_card;waves;" + (string)subject2);
          return;
      }
      if (card_num == question_card)
      {
          llSay(channel2, "test_card;question;" + (string)subject2);
          return;
      }
    }
}

// Initialize test results.
init_results(integer subject)
{
    if (subject == 1)
    {
        test_card1 = -1;
        trial1 = 0;
        correct1 = 0;
    } else {
        test_card2 = -1;
        trial2 = 0;
        correct2 = 0;
    }
}

// z-table
list z_values = [
0.00,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.10,0.11,0.12,0.13,0.14,0.15,0.16,
0.17,0.18,0.19,0.20,0.21,0.22,0.23,0.24,0.25,0.26,0.27,0.28,0.29,0.30,0.31,0.32,0.33,
0.34,0.35,0.36,0.37,0.38,0.39,0.40,0.41,0.42,0.43,0.44,0.45,0.46,0.47,0.48,0.49,0.50,
0.51,0.52,0.53,0.54,0.55,0.56,0.57,0.58,0.59,0.60,0.61,0.62,0.63,0.64,0.65,0.66,0.67,
0.68,0.69,0.70,0.71,0.72,0.73,0.74,0.75,0.76,0.77,0.78,0.79,0.80,0.81,0.82,0.83,0.84,
0.85,0.86,0.87,0.88,0.89,0.90,0.91,0.92,0.93,0.94,0.95,0.96,0.97,0.98,0.99,1.00,1.01,
1.02,1.03,1.04,1.05,1.06,1.07,1.08,1.09,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,
1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,
1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,
1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,
1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85,1.86,
1.87,1.88,1.89,1.90,1.91,1.92,1.93,1.94,1.95,1.96,1.97,1.98,1.99,2.00,2.01,2.02,2.03,
2.04,2.05,2.06,2.07,2.08,2.09,2.10,2.11,2.12,2.13,2.14,2.15,2.16,2.17,2.18,2.19,2.20,
2.21,2.22,2.23,2.24,2.25,2.26,2.27,2.28,2.29,2.30,2.31,2.32,2.33,2.34,2.35,2.36,2.37,
2.38,2.39,2.40,2.41,2.42,2.43,2.44,2.45,2.46,2.47,2.48,2.49,2.50,2.51,2.52,2.53,2.54,
2.55,2.56,2.57,2.58,2.59,2.60,2.61,2.62,2.63,2.64,2.65,2.66,2.67,2.68,2.69,2.70,2.71,
2.72,2.73,2.74,2.75,2.76,2.77,2.78,2.79,2.80,2.81,2.82,2.83,2.84,2.85,2.86,2.87,2.88,
2.89,2.90,2.91,2.92,2.93,2.94,2.95,2.96,2.97,2.98,2.99,3.00,3.25,3.50,3.75
];

list z_probabilities = [
0.5000,0.4960,0.4920,0.4880,0.4840,0.4801,0.4761,0.4721,0.4681,0.4641,0.4602,0.4562,
0.4522,0.4483,0.4443,0.4404,0.4364,0.4325,0.4286,0.4247,0.4207,0.4168,0.4129,0.4090,
0.4052,0.4013,0.3974,0.3936,0.3897,0.3859,0.3821,0.3783,0.3745,0.3707,0.3669,0.3632,
0.3594,0.3557,0.3520,0.3483,0.3446,0.3409,0.3372,0.3336,0.3300,0.3264,0.3228,0.3192,
0.3156,0.3121,0.3085,0.3050,0.3015,0.2981,0.2946,0.2912,0.2877,0.2843,0.2810,0.2776,
0.2743,0.2709,0.2676,0.2643,0.2611,0.2578,0.2546,0.2514,0.2483,0.2451,0.2420,0.2389,
0.2358,0.2327,0.2296,0.2266,0.2236,0.2206,0.2177,0.2148,0.2119,0.2090,0.2061,0.2033,
0.2005,0.1977,0.1949,0.1922,0.1894,0.1867,0.1841,0.1814,0.1788,0.1762,0.1736,0.1711,
0.1685,0.1660,0.1635,0.1611,0.1587,0.1562,0.1539,0.1515,0.1492,0.1469,0.1446,0.1423,
0.1401,0.1379,0.1357,0.1335,0.1314,0.1292,0.1271,0.1251,0.1230,0.1210,0.1190,0.1170,
0.1151,0.1131,0.1112,0.1093,0.1075,0.1056,0.1038,0.1020,0.1003,0.0985,0.0968,0.0951,
0.0934,0.0918,0.0901,0.0885,0.0869,0.0853,0.0838,0.0823,0.0808,0.0793,0.0778,0.0764,
0.0749,0.0735,0.0721,0.0708,0.0694,0.0681,0.0668,0.0655,0.0643,0.0630,0.0618,0.0606,
0.0594,0.0582,0.0571,0.0559,0.0548,0.0537,0.0526,0.0516,0.0505,0.0495,0.0485,0.0475,
0.0465,0.0455,0.0446,0.0436,0.0427,0.0418,0.0409,0.0401,0.0392,0.0384,0.0375,0.0367,
0.0359,0.0351,0.0344,0.0336,0.0329,0.0322,0.0314,0.0307,0.0301,0.0294,0.0287,0.0281,
0.0274,0.0268,0.0262,0.0256,0.0250,0.0244,0.0239,0.0233,0.0228,0.0222,0.0217,0.0212,
0.0207,0.0202,0.0197,0.0192,0.0188,0.0183,0.0179,0.0174,0.0170,0.0166,0.0162,0.0158,
0.0154,0.0150,0.0146,0.0143,0.0139,0.0136,0.0132,0.0129,0.0125,0.0122,0.0119,0.0116,
0.0113,0.0110,0.0107,0.0104,0.0102,0.0099,0.0096,0.0094,0.0091,0.0089,0.0087,0.0084,
0.0082,0.0080,0.0078,0.0075,0.0073,0.0071,0.0069,0.0068,0.0066,0.0064,0.0062,0.0060,
0.0059,0.0057,0.0055,0.0054,0.0052,0.0051,0.0049,0.0048,0.0047,0.0045,0.0044,0.0043,
0.0041,0.0040,0.0039,0.0038,0.0037,0.0036,0.0035,0.0034,0.0033,0.0032,0.0031,0.0030,
0.0029,0.0028,0.0027,0.0026,0.0026,0.0025,0.0024,0.0023,0.0023,0.0022,0.0021,0.0021,
0.0020,0.0019,0.0019,0.0018,0.0018,0.0017,0.0016,0.0016,0.0015,0.0015,0.0014,0.0014,
0.0013,0.0006,0.0002,0.0001
];

// z-score zener card probabilities.
float P = 0.2;   // p(hit)
float Q = 0.8;   // p(miss)

// Compute ESP ability using z-score.
// Reference: faculty.vassar.edu/lowry/ch6pt1.html
float compute_ability(integer n, integer k)
{
    float u = (float)n * P;
    if ((float)k < u) return 0.0;
    float s = llSqrt((float)n * P * Q);
    float z = (k - u) / s;
    integer i = 0;
    integer j = llGetListLength(z_values);
    for (i = 0; i < j; i++)
    {
        if (z < llList2Float(z_values, i))
        {
            return 1.0 - (2.0 * llList2Float(z_probabilities, i - 1));
        }
    }
    return 1.0;
}

integer min_significant_trials = 10;

// Update test results.
update_results(integer subject, integer result)
{
    float ability = 0.0;
    integer i;
    integer j;
    if (subject == 1)
    {
        correct1 = correct1 + result;
        trial1 = trial1 + 1;
        llSay(channel1, "score;Score=" + (string)correct1 + "/" + (string)trial1 + ";" + (string)subject1);
        if (trial1 < min_significant_trials)
        {
            llSay(channel1, "ability;ESP ability=(pending " + (string)min_significant_trials + " trials);" + (string)subject1);
        } else {
            ability = compute_ability(trial1, correct1);
            i = (integer)(ability * 100.0);
            j = (integer)(ability * 10000.0) - (i * 100);
            llSay(channel1, "ability;ESP ability=" + (string)i + "." + (string)j + "%;" + (string)subject1);
        }
    } else {
        correct2 = correct2 + result;
        trial2 = trial2 + 1;
        llSay(channel2, "score;Score=" + (string)correct2 + "/" + (string)trial2 + ";" + (string)subject2);
        if (trial2 < min_significant_trials)
        {
            llSay(channel2, "ability;ESP ability=(pending " + (string)min_significant_trials + " trials);" + (string)subject2);
        } else {
            ability = compute_ability(trial2, correct2);
            i = (integer)(ability * 100.0);
            j = (integer)(ability * 10000.0) - (i * 100);
            llSay(channel2, "ability;ESP ability=" + (string)i + "." + (string)j + "%;" + (string)subject2);
        }
    }
}

// Subject picks a card.
pick_card(integer subject, integer card_num)
{            
    if (subject == 1)
    {
       if (role1 == CLAIRVOYANCE_ROLE)
       {
           if (test_card1 != -1)
           {
               if (test_card1 == card_num)
               {
                   update_results(1, 1);
               } else {
                   update_results(1, 0);
               }
               show_card(1, test_card1);
               test_card1 = -1;
               llSay(channel1, "message;Click next to proceed;" + (string)subject1);
           } else {
               llSay(channel1, "message;Click next to proceed;" + (string)subject1);
           }
           return;
       }
       if (role1 == TELEPATH_SEND_ROLE)
       {
           if (test_card2 == -1)
           {
               llSay(channel1, "message;Click next to proceed;" + (string)subject1);
           } else {
               llSay(channel1, "message;Waiting on receiver;" + (string)subject1);
           }
           return;
       }
       if (role1 == TELEPATH_RECEIVE_ROLE)
       {
           if (test_card1 != -1)
           {
               if (card_pick == -1)
               {
                   card_pick = card_num;
                   if (test_card1 == card_num)
                   {
                       update_results(1, 1);
                       update_results(2, 1);
                   } else {
                       update_results(1, 0);
                       update_results(2, 0);
                   }
                   show_card(1, test_card1);
                   llSay(channel1, "message;Click next to proceed;" + (string)subject1);
               } else {
                   llSay(channel1, "message;Click next to proceed;" + (string)subject1);
               }
           } else {
               llSay(channel1, "message;Waiting on sender;" + (string)subject1);
           }
           return;
       }
    }
    else
    {
       if (role2 == CLAIRVOYANCE_ROLE)
       {
           if (test_card2 != -1)
           {
               if (test_card2 == card_num)
               {
                   update_results(2, 1);
               } else {
                   update_results(2, 0);
               }
               show_card(2, test_card2);
               test_card2 = -1;
               llSay(channel2, "message;Click next to proceed;" + (string)subject2);
           } else {
               llSay(channel2, "message;Click next to proceed;" + (string)subject2);
           }
           return;
       }
       if (role2 == TELEPATH_SEND_ROLE)
       {
           if (test_card1 == -1)
           {
               llSay(channel2, "message;Click next to proceed;" + (string)subject2);
           } else {
               llSay(channel2, "message;Waiting on receiver;" + (string)subject2);
           }
           return;
       }
       if (role2 == TELEPATH_RECEIVE_ROLE)
       {
           if (test_card2 != -1)
           {
               if (card_pick == -1)
               {
                   card_pick = card_num;
                   if (test_card2 == card_num)
                   {
                       update_results(1, 1);
                       update_results(2, 1);
                   } else {
                       update_results(1, 0);
                       update_results(2, 0);
                   }
                   show_card(2, test_card2);
                   llSay(channel2, "message;Click next to proceed;" + (string)subject2);
               } else {
                   llSay(channel2, "message;Click next to proceed;" + (string)subject2);
               }
           } else {
               llSay(channel2, "message;Waiting on sender;" + (string)subject2);
           }
           return;
       }
    }
}

default
{
    state_entry()
    {
        llListen(common_channel, "", NULL_KEY, "");
        llListen(channel1, "", NULL_KEY, "");
        llListen(channel2, "", NULL_KEY, "");
    }
 
    link_message(integer sender_num, integer num, string msg, key id)
    {
        // Subject is sitting or standing.
        if (num == 1)
        {
            // Check for duplicate message.
            if (id == subject1) return;

            // Seat 1.
            if (id == NULL_KEY)
            {
                // Reset HUD.
                if (subject1)
                {
                    llSay(channel1, "HUD;reset;" + (string)subject1);
                }
            }
            subject1 = id;
            role1 = NULL_ROLE;
            state1 = IDLE_STATE;
            if (subject1)
            {
                state1 = PRESENT_STATE;

                // Send channel in case HUD already attached.
                llSay(common_channel, (string)channel1 + ";" + (string)subject1);

                // Offer a HUD.
                llDialog(subject1, "Welcome to the ESP Test " + llKey2Name(subject1) + "\nPlease accept and attach to HUD",
                     ["OK"], common_channel);
            }
            return;
        }
        if (num == 2)
        {
            // Check for duplicate message.
            if (id == subject2) return;

            // Seat 2.
            if (id == NULL_KEY)
            {
                // Reset HUD.
                if (subject2)
                {
                    llSay(channel2, "HUD;reset;" + (string)subject2);
                }
            }
            subject2 = id;
            role2 = NULL_ROLE;
            state2 = IDLE_STATE;
            if (subject2)
            {
                state2 = PRESENT_STATE;

                // Send channel in case HUD already attached.
                llSay(common_channel, (string)channel2 + ";" + (string)subject2);

                // Offer a HUD.
                llDialog(subject2, "Welcome to the ESP Test " + llKey2Name(subject2) + "\nPlease accept and attach to HUD",
                     ["OK"], common_channel);
            }
            return;
        }
    }

    listen(integer channel, string name, key id, string message)
    {
        list request_list = llParseString2List(message, [";"], []);
        string request = "";
        key owner = NULL_KEY;

        if (channel == common_channel)
        {
            // Dialog response.
            if (id == subject1)
            {
                if (message == "OK")
                {
                    // Give HUD.
                    llGiveInventory(subject1, "ESP HUD");
                }
                return;
            }
            
            if (id == subject2)
            {             
                if (message == "OK")
                {
                    // Give HUD.
                    llGiveInventory(subject2, "ESP HUD");
                }
                return;
            }

            // Get request and source avatar.
            if (llGetListLength(request_list) != 2) return;
            request = llList2String(request_list, 0);
            owner = (key)llList2String(request_list, 1);

            // HUD requesting channel?
            if (request == "channel_request")
            {
                if (owner == subject1)
                {
                    llSay(common_channel, (string)channel1 + ";" + (string)subject1);
                    return;
                }
                if (owner == subject2)
                {
                    llSay(common_channel, (string)channel2 + ";" + (string)subject2);
                    return;
                }                   
            }
            return;
        }
            
        // Get request and source subject.
        if (llGetListLength(request_list) != 2) return;
        request = llList2String(request_list, 0);
        owner = (key)llList2String(request_list, 1);

        if (channel == channel1 && owner == subject1 && owner != NULL_KEY)
        {
            llSay(channel1, "message; ;" + (string)subject1);
            if (request == "detach")
            {
                state1 = PRESENT_STATE;
                role1 = NULL_ROLE;
                return;
            }
            if (request == "ready" && state1 == PRESENT_STATE)
            {
                state1 = READY_STATE;
                role1 = NULL_ROLE;
                llSay(channel1, "message;Toggle select to choose test;" + (string)subject1);
                return;
            }
            if (request == "init" && state1 > PRESENT_STATE)
            {
                state1 = READY_STATE;
                role1 = NULL_ROLE;
                llSay(channel1, "HUD;clear;" + (string)subject1);
                llSay(channel1, "message;Toggle select to choose test;" + (string)subject1);
                return;
            }
            if (request == "select" && state1 == READY_STATE)
            {
                if (role1 == NULL_ROLE)
                {
                    role1 = CLAIRVOYANCE_ROLE;
                    llSay(channel1, "title;Clairvoyance Test;" + (string)subject1);
                    return;
                }
                if (role1 == CLAIRVOYANCE_ROLE)
                {
                    role1 = TELEPATH_SEND_ROLE;
                    llSay(channel1, "title;Telepath Sender;" + (string)subject1);
                    return;
                }
                if (role1 == TELEPATH_SEND_ROLE)
                {
                    role1 = TELEPATH_RECEIVE_ROLE;
                    llSay(channel1, "title;Telepath Receiver;" + (string)subject1);
                    return;
                }
                if (role1 == TELEPATH_RECEIVE_ROLE)
                {
                    role1 = CLAIRVOYANCE_ROLE;
                    llSay(channel1, "title;Clairvoyance Test;" + (string)subject1);
                    return;
                }
                return;
            }
            if (request == "progress" && state1 == READY_STATE)
            {
                if (role1 == NULL_ROLE)
                {
                    return;
                }
                if (role1 == TELEPATH_SEND_ROLE)
                {
                   if (role2 == CLAIRVOYANCE_ROLE || role2 == TELEPATH_SEND_ROLE)
                   {
                       llSay(channel1, "message;Incompatible test roles;" + (string)subject1);
                       return;
                   }
                   if (role2 != TELEPATH_RECEIVE_ROLE)
                   {
                       llSay(channel1, "message;Test requires a telepath receiver;" + (string)subject1);
                       return;
                   }
                }
                if (role1 == TELEPATH_RECEIVE_ROLE)
                {
                   if (role2 == CLAIRVOYANCE_ROLE || role2 == TELEPATH_RECEIVE_ROLE)
                   {
                       llSay(channel1, "message;Incompatible test roles;" + (string)subject1);
                       return;
                   }
                   if (role2 != TELEPATH_SEND_ROLE)
                   {
                       llSay(channel1, "message;Test requires a telepath sender;" + (string)subject1);
                       return;
                   }
                }
                if (role1 == CLAIRVOYANCE_ROLE)
                {
                   state1 = TESTING_STATE;
                } else {
                   state1 = RENDEZVOUS_STATE;
                }
                init_results(1);
                card_pick = -1;
                llSay(channel1, "progress;next;" + (string)subject1);
                llSay(channel1, "score;Score=0/0;" + (string)subject1);                
            }
            if (state1 == RENDEZVOUS_STATE)
            {
                if (state2 == RENDEZVOUS_STATE)
                {
                    state1 = TESTING_STATE;
                    state2 = TESTING_STATE;
                    if (role1 == TELEPATH_SEND_ROLE)
                    {
                        test_card1 = (integer)llFrand(5.0);
                        show_card(1, test_card1);
                        llSay(channel1, "message;Click next to proceed;" + (string)subject1);
                        llSay(channel2, "message;Waiting on sender;" + (string)subject2);
                    } else {
                        test_card2 = (integer)llFrand(5.0);
                        show_card(2, test_card2);
                        llSay(channel2, "message;Click next to proceed;" + (string)subject2);
                        llSay(channel1, "message;Waiting on sender;" + (string)subject1);
                    }
                } else {
                    if (role1 == TELEPATH_SEND_ROLE)
                    {
                        llSay(channel1, "message;Waiting on receiver;" + (string)subject1);
                    } else {
                        llSay(channel1, "message;Waiting on sender;" + (string)subject1);
                    }
                }
                return;
            }
            if (state1 == TESTING_STATE)
            {
                if (role1 == TELEPATH_SEND_ROLE)
                {
                    if (state2 != TESTING_STATE || role2 != TELEPATH_RECEIVE_ROLE)
                    {
                        state1 = READY_STATE;
                        llSay(channel1, "HUD;clear;" + (string)subject1);
                        llSay(channel1, "message;Test requires a telepath receiver;" + (string)subject1);
                        return;
                    }
                }
                if (role1 == TELEPATH_RECEIVE_ROLE)
                {
                    if (state2 != TESTING_STATE || role2 != TELEPATH_SEND_ROLE)
                    {
                        state1 = READY_STATE;
                        llSay(channel1, "HUD;clear;" + (string)subject1);
                        llSay(channel1, "message;Test requires a telepath sender;" + (string)subject1);
                        return;
                    }
                }
            }
            if (request == "progress" && state1 == TESTING_STATE)
            {
                if (role1 == CLAIRVOYANCE_ROLE)
                {
                    if (test_card1 == -1)
                    {
                        test_card1 = (integer)llFrand(5.0);
                    }
                    llSay(channel1, "test_card;question;" + (string)subject1);
                    llSay(channel1, "message;Pick a card;" + (string)subject1);
                    return;
                }
                if (role1 == TELEPATH_SEND_ROLE)
                {
                    if (test_card2 == -1)
                    {
                        test_card2 = test_card1;
                        llSay(channel2, "message;Pick a card;" + (string)subject2);
                    }
                    llSay(channel1, "message;Waiting on receiver;" + (string)subject1);
                    return;
                }
                if (role1 == TELEPATH_RECEIVE_ROLE)
                {
                    if (test_card1 != -1)
                    {
                        if (card_pick != -1)
                        {
                            test_card1 = -1;
                            test_card2 = (integer)llFrand(5.0);
                            card_pick = -1;
                            show_card(1, question_card);
                            show_card(2, test_card2);
                            llSay(channel1, "message;Waiting on sender;" + (string)subject1);
                            llSay(channel2, "message;Click next to proceed;" + (string)subject2);
                        } else {
                            llSay(channel1, "message;Pick a card;" + (string)subject1);
                        }
                    } else {
                        llSay(channel1, "message;Waiting on sender;" + (string)subject1);
                    }
                    return;
                }
                return;
            }
            if (request == "circle_card" && state1 == TESTING_STATE)
            {
                pick_card(1, circle_card);
                return;
            }
            if (request == "cross_card" && state1 == TESTING_STATE)
            {
                pick_card(1, cross_card);
                return;
            }
            if (request == "square_card" && state1 == TESTING_STATE)
            {
                pick_card(1, square_card);
                return;
            }
            if (request == "star_card" && state1 == TESTING_STATE)
            {
                pick_card(1, star_card);
                return;
            }
            if (request == "waves_card" && state1 == TESTING_STATE)
            {
                pick_card(1, waves_card);
                return;
            }
            return;
        }
          
        if (channel == channel2 && owner == subject2 && owner != NULL_KEY)
        {
            llSay(channel2, "message; ;" + (string)subject2);
            if (request == "detach")
            {
                state2 = PRESENT_STATE;            
                role2 = NULL_ROLE;
                return;
            }
            if (request == "ready" && state2 == PRESENT_STATE)
            {
                state2 = READY_STATE;
                role2 = NULL_ROLE;
                llSay(channel2, "message;Toggle select to choose test;" + (string)subject2);
                return;
            }
            if (request == "init" && state2 > PRESENT_STATE)
            {
                state2 = READY_STATE;
                role2 = NULL_ROLE;
                llSay(channel2, "HUD;clear;" + (string)subject2);
                llSay(channel2, "message;Toggle select to choose test;" + (string)subject2);
                return;
            }
            if (request == "select" && state2 == READY_STATE)
            {
                if (role2 == NULL_ROLE)
                {
                    role2 = CLAIRVOYANCE_ROLE;
                    llSay(channel2, "title;Clairvoyance Test;" + (string)subject2);
                    return;
                }
                if (role2 == CLAIRVOYANCE_ROLE)
                {
                    role2 = TELEPATH_SEND_ROLE;
                    llSay(channel2, "title;Telepath Sender;" + (string)subject2);
                    return;
                }
                if (role2 == TELEPATH_SEND_ROLE)
                {
                    role2 = TELEPATH_RECEIVE_ROLE;
                    llSay(channel2, "title;Telepath Receiver;" + (string)subject2);
                    return;
                }
                if (role2 == TELEPATH_RECEIVE_ROLE)
                {
                    role2 = CLAIRVOYANCE_ROLE;
                    llSay(channel2, "title;Clairvoyance Test;" + (string)subject2);
                    return;
                }
                return;
            }
            if (request == "progress" && state2 == READY_STATE)
            {
                if (role2 == NULL_ROLE)
                {
                    return;
                }
                if (role2 == TELEPATH_SEND_ROLE)
                {
                   if (role1 == CLAIRVOYANCE_ROLE || role1 == TELEPATH_SEND_ROLE)
                   {
                       llSay(channel2, "message;Incompatible test roles;" + (string)subject2);
                       return;
                   }
                   if (role1 != TELEPATH_RECEIVE_ROLE)
                   {
                       llSay(channel2, "message;Test requires a telepath receiver;" + (string)subject2);
                       return;
                   }
                }
                if (role2 == TELEPATH_RECEIVE_ROLE)
                {
                   if (role1 == CLAIRVOYANCE_ROLE || role1 == TELEPATH_RECEIVE_ROLE)
                   {
                       llSay(channel2, "message;Incompatible test roles;" + (string)subject2);
                       return;
                   }
                   if (role1 != TELEPATH_SEND_ROLE)
                   {
                       llSay(channel2, "message;Test requires a telepath sender;" + (string)subject2);
                       return;
                   }
                }
                if (role2 == CLAIRVOYANCE_ROLE)
                {
                   state2 = TESTING_STATE;
                } else {
                   state2 = RENDEZVOUS_STATE;
                }
                init_results(2);
                card_pick = -1;
                llSay(channel2, "progress;next;" + (string)subject2);
                llSay(channel2, "score;Score=0/0;" + (string)subject2);
            }
            if (state2 == RENDEZVOUS_STATE)
            {
                if (state1 == RENDEZVOUS_STATE)
                {
                    state1 = TESTING_STATE;
                    state2 = TESTING_STATE;
                    if (role1 == TELEPATH_SEND_ROLE)
                    {
                        test_card1 = (integer)llFrand(5.0);
                        show_card(1, test_card1);
                        llSay(channel1, "message;Click next to proceed;" + (string)subject1);
                        llSay(channel2, "message;Waiting on sender;" + (string)subject2);
                    } else {
                        test_card2 = (integer)llFrand(5.0);
                        show_card(2, test_card2);
                        llSay(channel2, "message;Click next to proceed;" + (string)subject2);
                        llSay(channel1, "message;Waiting on sender;" + (string)subject1);
                    }
                } else {
                    if (role2 == TELEPATH_SEND_ROLE)
                    {
                        llSay(channel2, "message;Waiting on receiver;" + (string)subject2);
                    } else {
                        llSay(channel2, "message;Waiting on sender;" + (string)subject2);
                    }
                }
                return;
            }
            if (state2 == TESTING_STATE)
            {
                if (role2 == TELEPATH_SEND_ROLE)
                {
                    if (state1 != TESTING_STATE || role1 != TELEPATH_RECEIVE_ROLE)
                    {
                        state2 = READY_STATE;
                        llSay(channel2, "HUD;clear;" + (string)subject2);
                        llSay(channel2, "message;Test requires a telepath receiver;" + (string)subject2);
                        return;
                    }
                }
                if (role2 == TELEPATH_RECEIVE_ROLE)
                {
                    if (state1 != TESTING_STATE || role1 != TELEPATH_SEND_ROLE)
                    {
                        state2 = READY_STATE;
                        llSay(channel2, "HUD;clear;" + (string)subject2);
                        llSay(channel2, "message;Test requires a telepath sender;" + (string)subject2);
                        return;
                    }
                }
            }
            if (request == "progress" && state2 == TESTING_STATE)
            {
                if (role2 == CLAIRVOYANCE_ROLE)
                {
                    if (test_card2 == -1)
                    {
                        test_card2 = (integer)llFrand(5.0);
                    }
                    llSay(channel2, "test_card;question;" + (string)subject2);
                    llSay(channel2, "message;Pick a card;" + (string)subject2);
                    return;
                }
                if (role2 == TELEPATH_SEND_ROLE)
                {
                    if (test_card1 == -1)
                    {
                        test_card1 = test_card2;
                        llSay(channel1, "message;Pick a card;" + (string)subject1);
                    }
                    llSay(channel2, "message;Waiting on receiver;" + (string)subject2);
                    return;
                }
                if (role2 == TELEPATH_RECEIVE_ROLE)
                {
                    if (test_card2 != -1)
                    {
                        if (card_pick != -1)
                        {
                            test_card1 = (integer)llFrand(5.0);
                            test_card2 = -1;
                            card_pick = -1;
                            show_card(1, test_card1);
                            show_card(2, question_card);
                            llSay(channel2, "message;Waiting on sender;" + (string)subject2);
                            llSay(channel1, "message;Click next to proceed;" + (string)subject1);
                        } else {
                            llSay(channel2, "message;Pick a card;" + (string)subject2);
                        }
                    } else {
                        llSay(channel2, "message;Waiting on sender;" + (string)subject2);
                    }
                    return;
                }
                return;
            }
            if (request == "circle_card" && state2 == TESTING_STATE)
            {
                pick_card(2, circle_card);
                return;
            }
            if (request == "cross_card" && state2 == TESTING_STATE)
            {
                pick_card(2, cross_card);
                return;
            }
            if (request == "square_card" && state2 == TESTING_STATE)
            {
                pick_card(2, square_card);
                return;
            }
            if (request == "star_card" && state2 == TESTING_STATE)
            {
                pick_card(2, star_card);
                return;
            }
            if (request == "waves_card" && state2 == TESTING_STATE)
            {
                pick_card(2, waves_card);
                return;
            }
            return;
        }
    }

    touch_start(integer count)
    {
        llSay(0, "Please sit and try the ESP Test");
    }

    on_rez(integer param)
    {
        llResetScript();
    }

    changed(integer mask)
    {
        if(mask & CHANGED_OWNER)
        {
            llResetScript();
        }
    }    
}
