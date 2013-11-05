close
t = 0:0.000001:0.001;
function y = step(t)
    y = round((sign(t) + 1) / 2)
endfunction
function y = Pi(t)
    y = step(t + 0.5) - step(t - 0.5)
endfunction
function y = delta(t)
    y = 20000 * Pi(20000 * t);
endfunction

t0 = t(1);
y0 = [0;0];
L = 0.001;
R = 10;
C = 1e-6;
function zdot = RLCa(t, y)
    z1 = y(1);
    z2 = y(2);
    zdot(1) = z2;
    zdot(2) = (delta(t) - z1 - L*z2/R)/(L*C);
endfunction

function zdot = RLCb(t, y)
    z1 = y(1)
    z2 = y(2)
    zdot(1) = z2;
    zdot(2) = (step(t) - z1 - L*z2/R)/(L*C);
endfunction

function zdot = RLCc(t, y)
    z1 = y(1)
    z2 = y(2)
    zdot(1) = z2;
    zdot(2) = (sin(20000*%pi*t) .* step(t) - z1 - L*z2/R)/(L*C);
endfunction

function zdot = RLCd(t, y)
    z1 = y(1)
    z2 = y(2)
    zdot(1) = z2;
    zdot(2) = (sin(40000*%pi*t) .* step(t) - z1 - L*z2/R)/(L*C);
endfunction

scf(1)
clf(1)
y = ode(y0, t0, t, RLCa); 
plot(t, delta(t), t, y(1, :));
scf(2)
clf(2)
y = ode(y0, t0, t, RLCb);
plot(t, step(t), t, y(1, :));

scf(3)
clf(3)
y = ode(y0, t0, t, RLCc);
plot(t, sin(20000*%pi*t) .* step(t), t, y(1, :));

scf(4)
clf(4)
y = ode(y0, t0, t, RLCd);
plot(t, sin(40000*%pi*t) .* step(t), t, y(1, :));