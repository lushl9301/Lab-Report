function y = Pi(t)
    y = step(t + 0.5) - step(t - 0.5)
endfunction

function y = delta(t)
    y = 200 * Pi(200 * t);
endfunction

function y = expDelta(t)
    y = %e^t .* delta(t - 1)
endfunction