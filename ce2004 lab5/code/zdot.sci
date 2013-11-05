close

title("First one!");

t = 0:0.00001:0.001;
t0 = t(1);
y0 = [0,0];
L = 100;
R = 4.8;
C = 200;

function out = Vin(t)
    out = round((sign(t) + 1) / 2)
;
endfunction

function zdot = first(t, y)
    zdot(1) = y(2);
    zdot(2) = (Vin(t) - y(1) - L*y(2)/R)/(L*C);
endfunction

y = ode(y0, t0, t, first);
plot(t, y)