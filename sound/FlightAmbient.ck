//FlightAmbient by WWC
//Ambient sounds for air
//noise+filters for wind


// add
//    Machine.add( "foo.ck" ) => int id;

// remove shred with id
//   Machine.remove( id );

// add
//  Machine.add( "boo.ck" ) => id
// replace shred with "bar.ck"
//  Machine.replace( id, "bar.ck" );



//Global Param


//1000-9000hz
//wind_filter.set(3000, 3);

fun void windSpork(){
    .001 => float t;
    Noise wind => Gain g => ResonZ wind_filter => JCRev r => dac;
0.05 => r.mix;
0.05 => g.gain;
    while(true){
        

        100+Std.fabs(Math.sin(t) * 9000) => wind_filter.freq;
        t + .001 =>t;
        //<<<t>>>;
        100::ms => now;
    }    
}


2=> int i;

while(true){
    spork ~ windSpork();
    30::second=> now;
    i++;
    <<<i>>>;
    if(i>4){ 
        Machine.remove(i-3);
        <<<i>>>;
    }
}


