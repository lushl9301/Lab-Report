function y = kSumSin(k, t)
    y = 1/k * sin(k*t)
endfunction

function y = square_series(n, t)
    y = 0:0:0
    for i = 1 : 2 : n
        y = y + kSumSin(i, t)
    end
endfunction