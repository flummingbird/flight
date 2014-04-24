//FlightAvatar sound design by WWC
//SawOsc for Bird avatar
//TriOsc for Nimbus
//SinOsc for Ballon
//SqrOsc for Kite

SawOsc bird_osc => ADSR bird_env => JCRev r => dac;
TriOsc nimbus_osc => ADSR nimbus_env => r;
SinOsc balloon_osc => ADSR balloon_env => r;
SqrOsc kite_osc => ADSR kite_env => r;
//Global Param
0.0 => bird_osc.gain;
0.0 => nimbus_osc.gain;
0.0 => balloon_osc.gain;
0.0 => kite_osc.gain;

10 => int A;
80 => int D;
0.9 => float S;
100 => int R;


0.08 => r.mix;

//Specific Parameters
400 => bird_osc.freq;
bird_env.set((A+20)::ms, (D-70)::ms, S, (R+100)::ms);
A+20+D-70+R+100 => int birdDur;

1000 => nimbus_osc.freq;
nimbus_env.set((A+200)::ms, (D+100)::ms, S, (R+100)::ms);
A+200+D+100+R+100 => int nimbusDur;

800 => balloon_osc.freq;
balloon_env.set((A+20)::ms, (D-70)::ms, S, (R-90)::ms);
A+20+D-70+R-90 => int balloonDur;

300 => kite_osc.freq;
kite_env.set((A+100)::ms, D::ms, S, (R+100)::ms);
A+100+D+R+100 => int kiteDur;


//Open Sound Control from nexus:
OscRecv nexus;
7475 => nexus.port;
nexus.listen();
nexus.event("/bird, f") @=> OscEvent bird;
nexus.event("/nimbus, f") @=> OscEvent nimbus;
nexus.event("/balloon, f") @=> OscEvent balloon;
nexus.event("/kite, f") @=> OscEvent kite;


function void birdSpork()
{ 
    while(1) 
    {

        bird => now;
        while(bird.nextMsg() !=0)
        {
             
           
            bird.getFloat() => float keyBool;
            <<<keyBool>>>;
            if(keyBool==1)
            {
                0.25 => bird_osc.gain;
                bird_env.keyOn();
                birdDur::ms => now;
                bird_env.keyOff();
            }
        }
    }
}
function void nimbusSpork()
{ 
    while(1) 
    {
        
        nimbus => now;
        while(nimbus.nextMsg() !=0)
        {
            
            nimbus.getFloat() => float keyBool;
            <<<keyBool>>>;
            if(keyBool==1)
            {
                0.9 => nimbus_osc.gain;
                nimbus_env.keyOn();
                nimbusDur::ms => now;
                nimbus_env.keyOff();
            }
        }
    }
}    
function void balloonSpork()
{ 
    while(1) 
    {
        
        balloon => now;
        while(balloon.nextMsg() !=0)
        {
            
            balloon.getFloat() => float keyBool;
            <<<keyBool>>>;
            if(keyBool==1)
            {
                0.5 => balloon_osc.gain;
                balloon_env.keyOn();
                balloonDur::ms => now;
                balloon_env.keyOff();
            }
        }
    }
}
function void kiteSpork()
{ 
    while(1) 
    {
        
        kite => now;
        while(kite.nextMsg() !=0)
        {
            
            kite.getFloat() => float keyBool;
            <<<keyBool>>>;
            if(keyBool==1)
            {
                0.25 => kite_osc.gain;
                kite_env.keyOn();
                kiteDur::ms => now;
                kite_env.keyOff();
            }
        }
    }
}
    
spork ~ birdSpork();
spork ~ nimbusSpork();
spork ~ balloonSpork();
spork ~ kiteSpork();

<<<"sporked">>>;


while(1)
    0.5::day=> now;
