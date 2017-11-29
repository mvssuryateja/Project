function [frames,indexes] = frames_window_r( vec, Nw, Ns,window)
    if( min(size(vec))~=1 ||Nw==0 || Ns==0 ); end %ensure inputs are correct
    vec = vec(:);                       % ensure column vector
    L = length( vec );                  % length of the input vector
    M = floor((L-Nw)/Ns+1);             % number of frames 
    % compute index matrix 
       indf = Ns*[0:(M-1)];% indexes for frames      
       inds = [1:Nw].';     % indexes for samples
       indexes = indf(ones(Nw,1),:) + inds(:,ones(1,M)); % combined framing indexes 
    frames = vec( indexes );% divide the input signal into frames using indexing
    % return if custom analysis windowing was not requested
       if( isempty(window) || ( islogical(window) && ~window ) ), return; end
    % if analysis window function handle was specified, generate window samples
       if( isa(window,'function_handle') )
        window = window( Nw );end
    % make sure analysis window is numeric and of correct length, otherwise return
       if( isnumeric(window) && length(window)==Nw )
         frames = diag( window ) * frames;end

