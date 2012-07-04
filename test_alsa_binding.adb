with Ada.Text_IO;
with Sound.Mono_Recording;

procedure Test_ALSA_Binding is
   Microphone : Sound.Mono_Recording.Line_Type;
   Resolution : Sound.Sample_Frequency := 44_100;
begin
   Sound.Mono_Recording.Open (Line       => Microphone,
                              Resolution => Resolution);
   Ada.Text_IO.Put_Line ("Resolution [samples/s]: " &
                           Sound.Sample_Frequency'Image (Resolution));
   Sound.Mono_Recording.Close (Line => Microphone);
end Test_ALSA_Binding;
