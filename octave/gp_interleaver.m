% gp_interleaver.m
%
% David Rowe May 2017
%
% Golden Prime Interleaver. My interprestation of "On the Analysis and
% Design of Good Algebraic Interleavers", Xie et al,eq (5).

1;

% return 1 if prime
function ret = is_prime(x)
  for i=2:x-1
    if mod(x,i) == 0
      ret = 0;
      return;
    end
  end
  ret = 1;
end

function x = next_prime(x)
  x++;
  while is_prime(x) == 0
    x++;
  end
end

% Choose b for Golden Prime Interleaver.  b is chosen to be the
% closest integer, which is relatively prime to N, to the Golden
% section of N.

function b = choose_interleaver_b(Nbits)
  b = floor(Nbits/1.62);
  b = next_prime(b);
  assert(gcd(b,Nbits) == 1, "b and Nbits must be co-prime");
end


function interleaved_frame = gp_interleave(frame)
  Nbits = length(frame);
  b = choose_interleaver_b(Nbits);
  interleaved_frame = zeros(1,Nbits);
  for i=1:Nbits
    j = mod((b*(i-1)), Nbits);
    interleaved_frame(j+1) = frame(i);
  end
endfunction


function frame = gp_deinterleave(interleaved_frame)
  Nbits = length(interleaved_frame);
  b = choose_interleaver_b(Nbits); 
  frame = zeros(1,Nbits);
  for i=1:Nbits
    j = mod((b*(i-1)), Nbits);
    frame(i) = interleaved_frame(j+1);
  end
endfunction

