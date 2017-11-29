function [ H, f, c ] = trifilter_r( M, K, R, fs, h2w, w2h )
    if( nargin~= 6 ), help trifbank; return; end; % very lite input validation
    min = 0;          % filter coefficients start at this frequency (Hz)
    low = R(1);       % lower cutoff frequency (Hz) for the filterbank 
    high = R(2);      % upper cutoff frequency (Hz) for the filterbank 
    max = 0.5*fs;     % filter coefficients end at this frequency (Hz)
    f = linspace( min, max, K ); % frequency range (Hz)
    fw = h2w( f );
    c = w2h( h2w(low)+[0:M+1]*((h2w(high)-h2w(low))/(M+1)) );% filter cutoff frequencies (Hz) for all filters
    cw = h2w( c );
    H = zeros( M, K );                  % zero otherwise
    for m = 1:M 
        k = f>=c(m)&f<=c(m+1); % up-slope
        H(m,k) = (f(k)-c(m))/(c(m+1)-c(m));
        k = f>=c(m+1)&f<=c(m+2); % down-slope
        H(m,k) = (c(m+2)-f(k))/(c(m+2)-c(m+1));end

