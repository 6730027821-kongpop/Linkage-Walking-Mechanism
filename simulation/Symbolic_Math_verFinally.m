%% =====================================================================
%  Linkage Walking Mechanism  -  ขาเดียว (single leg)
%   - ก้านหมุน (crank) รัศมี r หมุนรอบ O = (0,0) ด้วยมุม th
%   - หมุด P บนก้านหมุนที่ตำแหน่ง P = r[cos th ; sin th]
%   - ปลอกสีเหลือง (collar) Y ติดกับตัวถังที่ (0, d)
%   - ก้านแดงยาว L ต่อจากหมุด P ลอดผ่านปลอก Y ไปสิ้นสุดที่ปลายบน T
%   - ขา (สีเทา) ตั้งตรงเสมอ เพราะวิ่งผ่านตัวเลื่อนในร่องแนวนอน
%     => T และเท้า F มีพิกัด x เท่ากัน,  F = T - [0 ; H]
%% =====================================================================
%% STEP 0 : วิเคราะห์ DOF
%  Grubler-Equation (planar):  F = 3(Nl-1) - 2*J1 - J2
%  Links (Nl = 6): 0 ground, 1 crank, 2 ก้านแดง, 3 ปลอก Y,
%                  4 ขา, 5 ตัวเลื่อนแนวนอน
%  Lower pairs (J1 = 7):
%     R  ground - crank        (แกน O)
%     R  crank  - ก้านแดง      (หมุด P)
%     P  ก้านแดง - ปลอก Y       (ก้านเลื่อนผ่านปลอก)
%     R  ปลอก Y - ground       (จุด (0,d))
%     R  ก้านแดง - ขา          (ปลายบน T)
%     P  ขา - ตัวเลื่อน         (ขาเลื่อนขึ้นลงแนวตั้ง)
%     P  ตัวเลื่อน - ground     (ร่องแนวนอน)
%  Higher pairs (J2 = 0)
Nl = 6;  J1 = 7;  J2 = 0;
F_grubler = 3*(Nl-1) - 2*J1 - J2;
fprintf('--- DOF (Grubler-Equation) ---\n Nl=%d  J1=%d  J2=%d  ->  F = %d\n\n',Nl, J1, J2, F_grubler);
%% STEP 1 : ประกาศตัวแปรสัญลักษณ์
syms r d L H omega positive      % ขนาดทางเรขาคณิต และความเร็วเชิงมุมคงที่
syms th real                     % มุมก้านหมุน  th = omega*t
%% STEP 2 : ตำแหน่งหมุด และปลอก
P = [ r*cos(th); r*sin(th) ];
Y = [ 0; d ];
%% STEP 3 : สมการเงื่อนไข (constraint equations) ของก้านแดง
%  ปลายบน T = [xT; yT] ต้องสอดคล้อง 2 เงื่อนไข
%   (ก) P, Y, T อยู่บนเส้นตรงเดียวกัน (ก้านลอดผ่านปลอก)
%   (ข) |T - P| = L
syms xT yT real
eq_collinear = (xT-P(1))*(Y(2)-P(2)) - (yT-P(2))*(Y(1)-P(1)) == 0;
eq_length    = (xT-P(1))^2 + (yT-P(2))^2 == L^2;
%  คำตอบ: T = P + L*(Y-P)/|Y-P|   (อยู่เลยปลอกออกไป)
T = simplify(P + L*(Y-P)/sqrt((Y-P).'*(Y-P)));
%  ตรวจสอบคำตอบกับสมการเงื่อนไข (ต้องเป็น 0)
chk_collinear = simplify((T(1)-P(1))*(Y(2)-P(2)) - (T(2)-P(2))*(Y(1)-P(1)));
chk_length    = simplify(expand((T-P).'*(T-P) - L^2));
fprintf('ตรวจสอบเงื่อนไขเส้นตรง = %s,  ตรวจสอบความยาวก้าน = %s\n',char(chk_collinear), char(chk_length));
%% STEP 4 : ตำแหน่งเท้า   rho = |Y-P|
rho = sqrt(r^2 + d^2 - 2*r*d*sin(th));
F   = [ r*cos(th)*(1 - L/rho);  r*sin(th) + L*(d - r*sin(th))/rho - H ];
disp('ความต่างของ F กับ T-[0;H] (ควรได้ 0):');
disp(simplify(F - (T - [0;H])));
disp('F(th) = '); disp(F);
%% STEP 4b : DOF จาก Jacobian ของสมการเงื่อนไข
syms xA yA real
eqs = [ (xA-P(1))*(Y(2)-P(2)) - (yA-P(2))*(Y(1)-P(1));
        (xA-P(1))^2 + (yA-P(2))^2 - L^2 ];
q  = [th xA yA];
Jc = jacobian(eqs, q);                                  % 2 x 3
for th0 = linspace(0, 2*pi, 13)
    Tn = double(subs(T, [r d L th], [20 49.3 161.7 th0]));
    Jn = double(subs(Jc, [r d L th xA yA], [20 49.3 161.7 th0 Tn.']));
    fprintf('th = %5.1f deg : rank(J) = %d -> DOF = %d\n',th0*180/pi, rank(Jn), size(Jn,2) - rank(Jn));
end
%% STEP 5 : ความเร็วและความเร่งของเท้า
V = diff(F, th)*omega;
A = diff(V, th)*omega;
%% STEP 6 : แทนค่าตัวเลข (หน่วย mm, rad/s)
p.r = 22.465;  p.d = 50.00 ;  p.L = 165.22;  p.H = 273.582;  p.w = 2*pi;   % 60 rpm  (สัดส่วน d/r=2.46, L/r=8.09 ฟิตจาก trajectory ใน Fusion; หน่วย mm สมมติ r=20 ต้องแทนด้วยค่าจริง)
assert(p.d > p.r && p.L > p.d + p.r, 'ค่าพารามิเตอร์ละเมิดเงื่อนไขการประกอบ');
num = @(e) subs(e, [r d L H omega], [p.r p.d p.L p.H p.w]);
fx  = matlabFunction(num(F(1)), 'Vars', th);
fy  = matlabFunction(num(F(2)), 'Vars', th);
fvx = matlabFunction(num(V(1)), 'Vars', th);
fvy = matlabFunction(num(V(2)), 'Vars', th);
fax = matlabFunction(num(A(1)), 'Vars', th);
fay = matlabFunction(num(A(2)), 'Vars', th);
fT  = matlabFunction(num(T),    'Vars', th);
Ns  = 2000;
thn = linspace(0, 2*pi, Ns+1);  thn(end) = [];          % 1 รอบ ไม่ซ้ำจุดปลาย
x  = fx(thn);  yraw = fy(thn);
ymin = min(yraw);
y  = yraw - ymin;                                       % จุดต่ำสุดของเท้า = พื้น
vx = fvx(thn);  vy = fvy(thn);  ax = fax(thn);  ay = fay(thn);
spd = hypot(vx, vy);  acc = hypot(ax, ay);
%% STEP 7 : ลักษณะการเคลื่อนที่ (motion characteristics)
stride = max(x) - min(x);              % ช่วงกวาดของเท้าตามแนวนอน
height = max(y) - min(y);              % ความสูงยกเท้า
eps_g  = 0.05;                         % แตะพื้นเมื่อสูงไม่เกิน 5% ของ height
stance = y <= eps_g*height;
duty   = mean(stance);                 % duty factor
vst    = mean(vx(stance));             % ความเร็วเฉลี่ยเท้าช่วงแตะพื้น
fluct  = std(vx(stance))/abs(vst);     % ความไม่สม่ำเสมอของความเร็วช่วงแตะพื้น
step_len = max(x(stance)) - min(x(stance));   % ระยะที่เท้าลากต่อ 1 รอบ
fprintf('\n=== ผลลัพธ์ (r=%g, d=%g, L=%g, H=%g mm, %.0f rpm) ===\n',p.r, p.d, p.L, p.H, p.w*30/pi);
fprintf('ช่วงก้าวของเท้า (stride)        : %.1f mm\n', stride);
fprintf('ความสูงยกเท้า (step height)     : %.1f mm\n', height);
fprintf('Duty factor (stance fraction)   : %.2f\n', duty);
fprintf('ความเร็วเท้าช่วงแตะพื้น (เฉลี่ย) : %.1f mm/s  (แกว่ง %.1f %%)\n', vst, 100*fluct);
fprintf('ระยะเท้าลากช่วงแตะพื้นต่อรอบ     : %.1f mm\n', step_len);
fprintf('ความเร็วเท้าสูงสุด               : %.1f mm/s\n', max(spd));
fprintf('ความเร่งเท้าสูงสุด               : %.1f mm/s^2\n', max(acc));
%% STEP 8 : กราฟ
figure('Name','trajectory ของเท้า'); hold on; axis equal; grid on;
plot(x, y, 'b-', 'LineWidth', 1.8);
plot(x(stance), y(stance), 'r.', 'MarkerSize', 8);
xlabel('x [mm]'); ylabel('y [mm] (พื้น = 0)');
title('Foot trajectory (1 รอบก้านหมุน)'); legend('path','stance');
saveas(gcf, 'fig_trajectory_single_leg.png');
figure('Name','Kinematics');
subplot(3,1,1); plot(rad2deg(thn), [x; y].', 'LineWidth', 1.3); grid on;
ylabel('position [mm]'); legend('x','y');
subplot(3,1,2); plot(rad2deg(thn), [vx; vy].', 'LineWidth', 1.3); grid on;
ylabel('velocity [mm/s]'); legend('v_x','v_y');
subplot(3,1,3); plot(rad2deg(thn), [ax; ay].', 'LineWidth', 1.3); grid on;
ylabel('accel. [mm/s^2]'); xlabel('\theta [deg]'); legend('a_x','a_y');
saveas(gcf, 'fig_kinematics_single_leg.png');
%% STEP 9 : ภาพเคลื่อนไหวของกลไก
figure('Name','Animation (single leg)');
for k = 1:20:Ns
    cla; hold on; axis equal; grid on; axis([-150 150 -150 200]);
    a  = thn(k);
    pn = [p.r*cos(a); p.r*sin(a)];
    Yn = [0; p.d];
    tn = fT(a);
    plot([-p.r*cos(a) pn(1)], [-p.r*sin(a) pn(2)], 'bo-');        % ก้านหมุน
    plot([pn(1) tn(1)], [pn(2) tn(2)], 'r-', 'LineWidth', 2);     % ก้านแดง
    plot([tn(1) tn(1)], [tn(2) tn(2)-p.H], 'k-', 'LineWidth', 3); % ขา
    plot(Yn(1), Yn(2), 's', 'MarkerFaceColor', 'y', 'MarkerSize', 10); % ปลอก Y
    plot(x(1:k), yraw(1:k), 'b:');                                % trajectory เท้า
    drawnow;
end