function [ CC,frames ] = mfcc_r( speech, fs, Tw, Ts, a, window, R, M, N)
    if( nargin~= 9 ), help mfcc; return; end; % ensure number of inputs are correct
    if( max(abs(speech))<=1 ), speech = speech * 2^15; end;% Explode samples to the range of 16 bit shorts
    Nw = round( 1E-3*Tw*fs );    % frame duration (samples)
    Ns = round( 1E-3*Ts*fs );    % frame shift (samples)
    nfft = 2^nextpow2( Nw );     % length of FFT analysis 
    K = nfft/2+1;                % length of the unique part of the FFT 
    h2m = @( hz )( 1127*log(1+hz/700) );     % Hertz to mel warping function
    m2h = @( mel )( 700*exp(mel/1127)-700 ); % mel to Hertz warping function
    dctm = @( N, M )( sqrt(2.0/M) * cos( repmat([0:N-1].',1,M).* repmat(pi*([1:M]-0.5)/M,N,1)));
    speech = filter( [1 -a], 1, speech );% Preemphasis filtering  % fvtool( [1 -alpha], 1 );
    frames = frames_window_r( speech, Nw, Ns, window); % Framing and windowing (frames as columns)
    MAG = abs( fft(frames,nfft,1) );% Magnitude spectrum computation (as column vectors)
    H = trifilter_r( M, K, R, fs, h2m, m2h ); % Triangular filterbank with uniformly spaced filters on mel scale                                               
    FBE = H * MAG(1:K,:); % FBE( FBE<1.0 ) = 1.0; % apply mel floor
    DCT = dctm( N, M ); % DCT matrix computation
    CC =  DCT * log( FBE );% Conversion of logFBEs to cepstral coefficients through DCT
   
