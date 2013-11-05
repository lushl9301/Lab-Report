close

title("Second One!");

t = -10:0.01:10;
t0 = t(1);
y0 = [0,0];

function zdot = second(t, y)
    zdot(1) = y(2);
    zdot(2) = y(1) + 0.5;
endfunction

x = ode(y0, t0, t, second);
plot(x)