function y = step(t)
    y = round((sign(t) + 1) / 2)
endfunction

function y = Pi(t)
    y = step(t + 0.5) - step(t - 0.5)
endfunction

function y = wavA(t)
    y = sin(261.63*2*%pi*t)
endfunction

function y = sumOfWav(t)
    y = sin(261.63*2*%pi*t) + sin(329.63*2*%pi*t) + sin(392.00*2*%pi*t)
endfunction

function y = sixSecond(t)
    y = (sin(261.63*2*%pi*t) .* Pi(1/4.41*t-0.5)) + (sin(329.63*2*%pi*t) .* Pi(1/4.41*t-1.5)) + (sin(392.00*2*%pi*t) .* Pi(1/4.41*t-2.5))
endfunction

function y= sixSecond2(t)
    y = (sin(261.63*2*%pi*t) .* Pi(1/441*t-0.5)) + (sin(329.63*2*%pi*t) .* Pi(1/441*t-1.5)) + (sin(392.00*2*%pi*t) .* Pi(1/441*t-2.5))
endfunction