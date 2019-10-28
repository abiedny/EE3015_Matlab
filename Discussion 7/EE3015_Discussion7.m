load('3015_Discussion_7_Matlab.mat');

for n = 1:4
    switch n
        case 1
            signal = oboe;
            w0 = 440;
        case 2
            signal = sax;
            w0 = 440;
        case 3
            t_cosine = 0:1/fs:5;
            cosine=cos(2*pi*t_cosine*440);
            signal = cosine;
            w0 = 440;
        case 4
            signal = piano;
            w0 = 220;
    end
    
    t = (0:1/fs:(length(signal)-1)/fs)';
    plot(t, signal); %full signal plot
    
    start_sustain_index = find(t == 0.5);
    end_sustain_index = find(t == 1);
    signal_sustain = signal(start_sustain_index:end_sustain_index);
    t_sustain = t(start_sustain_index:end_sustain_index);
    hold on;
    plot(t_sustain, signal_sustain); %just a chunk of the sustain portion, for reference
    
    starti = find(signal_sustain == 0, 1);
    [accuracy, endi] = min(abs(t_sustain - (t_sustain(starti) + 1/w0)));
    period = signal_sustain(starti:endi);
    t_period = t_sustain(starti:endi);
    hold off; %clear out the other plots to plot one period
    figure(n);
    plot(t_period, period); % one period plot
    figure(n+4);
    coeffs = fft(period)/length(period);
    coeffs = fftshift(coeffs);
    stem(abs(coeffs));
end
