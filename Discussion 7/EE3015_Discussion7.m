%yeah this code is hot garbage apologies to whoever has to read it
load('3015_Discussion_7_Matlab.mat');

%generate cosine signal
t_cosine = 0:1/fs:3;
cosine = cos(2*pi*t_cosine*440);

%oboe
signal = oboe;
w0 = 440; 

t = (0:1/fs:(length(signal)-1)/fs)';

start_sustain_index = find(t == 0.5);
end_sustain_index = find(t == 1);
signal_sustain = signal(start_sustain_index:end_sustain_index);
t_sustain = t(start_sustain_index:end_sustain_index);

starti = find(signal_sustain == 0, 1);
[~, endi] = min(abs(t_sustain - (t_sustain(starti) + 1/w0)));
period = signal_sustain(starti:endi);
t_period = t_sustain(starti:endi);
figure(1);
plot(t_period, period); % one period plot
figure(2);
oboe_coeffs = fft(period)/length(period);
oboe_coeffs = fftshift(oboe_coeffs);
stem(abs(oboe_coeffs));

%sax
signal = sax;
w0 = 440; 

t = (0:1/fs:(length(signal)-1)/fs)';

start_sustain_index = find(t == 1);
end_sustain_index = find(t == 2);
signal_sustain = signal(start_sustain_index:end_sustain_index);
t_sustain = t(start_sustain_index:end_sustain_index);

starti = find(signal_sustain == 0, 1);
[~, endi] = min(abs(t_sustain - (t_sustain(starti) + 1/w0)));
period = signal_sustain(starti:endi);
t_period = t_sustain(starti:endi);
figure(3);
plot(t_period, period); % one period plot
figure(4);
coeffs = fft(period)/length(period);
coeffs = fftshift(coeffs);
stem(abs(coeffs));

%cosine
signal = cosine;
w0 = 440; 

t = (0:1/fs:(length(signal)-1)/fs)';

start_sustain_index = find(t == 1);
end_sustain_index = find(t == 2);
signal_sustain = signal(start_sustain_index:end_sustain_index);
t_sustain = t(start_sustain_index:end_sustain_index);

starti = find(signal_sustain == 1, 1);
[~, endi] = min(abs(t_sustain - (t_sustain(starti) + 1/w0)));
period = signal_sustain(starti:endi);
t_period = t_sustain(starti:endi);
figure(5);
plot(t_period, period); % one period plot
figure(6);
coeffs = fft(period)/length(period);
coeffs = fftshift(coeffs);
stem(abs(coeffs));

%Question 5: Out of all the signals, the oboe has the largest harmonics.
%As is expected, the pure cosine signal only has two harmonics at 1 and -1,
%with the harmonic at 0 being equal to 0. The saxaphone signal falls in
%between, with its harmonics not being as large as the oboe, but having two
%very large harmonics at 1 and -1.

%piano
signal = piano;
w0 = 220; 

t = (0:1/fs:(length(signal)-1)/fs)';

start_sustain_index = find(t == 0.5);
end_sustain_index = find(t == 1);
signal_sustain = signal(start_sustain_index:end_sustain_index);
t_sustain = t(start_sustain_index:end_sustain_index);

starti = find(signal_sustain == 0, 1);
[~, endi] = min(abs(t_sustain - (t_sustain(starti) + 1/w0)));
period = signal_sustain(starti:endi);
t_period = t_sustain(starti:endi);
figure(7);
plot(t_period, period); % one period plot
figure(8);
coeffs = fft(period)/length(period);
coeffs = fftshift(coeffs);
stem(abs(coeffs));

%Question 6: The piano's harmonics are small compared to the other signals,
%but they are distributed relatively simmilar to the saxaphone harmonics.

t = 0:1/fs:3;
x1 = exp(1j*2*pi*440*t);

t_period = find(t >= 0 & t <= 1/440);
x1_period = x1(1:101);
figure(9);
plot(t_period, x1_period);

%Question 7: We are obtaining a cosine signal.

%root of coeffs is at 51, +- 14 is loop
x = 0;
for n = 37:65
    k = n - 51;
    x = x + oboe_coeffs(n) * exp(1j*k*2*pi*440*t);
end
figure(10);
plot(t_period, x(1:101));

%Question 8: The signal looks nearly identical to the original oboe signal.
%When listening to it, it sounds nearly identical to the original oboe as
%well

x_abs = 0;
for n = 37:65
    k = n - 51;
    x_abs = x_abs + abs(oboe_coeffs(n)) * exp(1j*k*2*pi*440*t);
end
figure(11);
plot(t_period, x_abs(1:101));

%Question 9: The two signals are noticably different, the absolute value
%one sounds much more mechanical and robotic, whereas the signal without
%absolute value sounds much more natural.
