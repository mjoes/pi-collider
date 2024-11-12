"SC_JACK_DEFAULT_OUTPUTS".setenv(
        "darkice-jack:left,"
        "darkice-jack:right,"
);
s.options.numOutputBusChannels = 2;
s.waitForBoot {
  p = thisProcess.nowExecutingPath.dirname +/+ "tbp.mp3";
  b = Buffer.read(s, p);

  Ndef(\playTBP, {
    |tibber=2000|
    var out;
    var ringAmount = tibber-300;
    var delayAmount = tibber / 4000;
    // var shiftAmount = SinOsc.kr(5).range(-delayAmount, delayAmount);
    var modulator =  SinOsc.ar(tibber, 0);
    out = PlayBuf.ar(1, b.bufnum, BufRateScale.kr(b.bufnum), loop: 1);
    out = DelayN.ar(out, 0.5, 0.1) * delayAmount + out;
    out = Decimator.ar(out, (tibber).linexp(0, 5000, 20000, 500));
    out = Mix([out * (1 - (ringAmount / 4000)), (out * modulator * (ringAmount / 4000);)]);
    //out = FreqShift.ar(out, shiftAmount);
    Out.ar(0, [out, out]);
  }).play;
};

OSCdef(\setter, {|msg| msg[1].postln; Ndef(\playTBP).set(\tibber, msg[1]);}, '/tibber');
