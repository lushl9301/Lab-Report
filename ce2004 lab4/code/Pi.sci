function y = step(t)
    y = round((sign(t) + 1) / 2)
endfunction
function y = Pi(t)
    y = step(t + 0.5) - step(t - 0.5)
endfunction

function y = Pic(t)
    y = Pi(0.5*t-2) + 2*Pi(0.5*t-1) + 3*Pi(0.5*t) + 2*Pi(0.5*t+1) + Pi(0.5*t+2)
endfunction