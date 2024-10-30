"SC_JACK_DEFAULT_OUTPUTS".setenv(
        "darkice-jack:left,"
        "darkice-jack:right,"
);
s.options.numOutputBusChannels = 2;
s.waitForBoot {
	Ndef(\myNote, {
		|pitch=444| 
    var note;
		note = { SinOsc.ar(pitch-1000, 0, 0.5) };
		Out.ar(0, [note, note]);
	}).play;
};
OSCdef(\setter, {|msg| msg[1].postln; Ndef(\myNote).set(\pitch, msg[1]);}, '/tibber');


