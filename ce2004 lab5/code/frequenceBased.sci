
function y = step(t)
    y = round((sign(t) + 1) / 2)
endfunction

function y = Pi(t)
    y = step(t + 0.5) - step(t - 0.5)
endfunction

t = 0:0.000001:0.001;
R = 10;
L = 0.001;
C = 1e-6;
s = poly(0, "s");
function x = Vina(t)
    x = sin(20000*%pi*t) .* round((sign(t) + 1) / 2);
endfunction
function x = Vinb(t)
    x = sin(40000*%pi*t) .* round((sign(t) + 1) / 2);
endfunction
lin_sys = syslin('c', 1 / (1+L*s/R+L*C*s^2));

y = csim(Vina, t, lin_sys);
scf(1)
clf(1)
plot(t, Vina, t, y(1, 1:length(t)'));
y = csim(Vinb, t, lin_sys);
scf(7)
clf(7)
plot(t, Vinb, t, y(1, 1:length(t)'));

scf(0)
clf(0)
plot(t, csim(Vina, t, lin_sys), t, csim(Vinb, t, lin_sys));
bode(lin_sys, 1, 50000);