load('3015_Discussion_7_Matlab.mat')
t = (0:1/fs:(length(oboe)-1)/fs)';
plot(t, oboe); %full signal plot

start_sustain_index = find(t == 0.5);
end_sustain_index = find(t == 1);
oboe_sustain = oboe(start_sustain_index:end_sustain_index);
t_sustain = t(start_sustain_index:end_sustain_index);
hold on;
plot(t_sustain, oboe_sustain); %just a chunk of the sustain portion, for reference

starti = find(oboe_sustain == 0, 1);
[accuracy, endi] = min(abs(t_sustain - (t_sustain(starti) + 1/440)));
period = oboe_sustain(starti:endi);
t_period = t_sustain(starti:endi);
hold off; %clear out the other plots to plot one period
figure(1);
plot(t_period, period); % one period plot
figure(2);
coeffs = fft(period)/length(period);
coeffs = fftshift(coeffs);
stem(abs(coeffs));
