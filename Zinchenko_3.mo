package Zinchenko
  model lab1_4var_fp
    Real x1[11];
    Real x2[11];
  initial equation
    for i in 1:11 loop
      x1[i] = 0;
      x2[i] = 2 - 0.25 * i;
    end for;
  equation
    for i in 1:11 loop
      der(x1[i]) = x2[i];
      der(x2[i]) = x2[i] * (1 - x1[i] ^ 2) - x1[i];
    end for;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
  end lab1_4var_fp;

  model lab1_4var
    Real x1(start = 1);
    Real x2(start = 0);
  equation
    der(x1) = x2;
    der(x2) = x2 * (1 - x1 ^ 2) - x1;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
  end lab1_4var;

  model lab1_4var_9
    Real x1(start = 1);
    Real x2(start = 0);
    Real x3(start = 0);
  equation
    der(x1) = -x2 ^ 5;
    der(x2) = x1 + x2 ^ 2;
    der(x3) = x3;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
  end lab1_4var_9;

  model lab1_4var_9_fp
    Real x1[12];
    Real x2[12];
    Real x3[12];
  initial equation
    for i in 1:11 loop
      x1[i] = i - 0.01 * i;
      x2[i] = 2 - 0.25 * i;
      x3[i] = 0.75 * i + 1;
      x1[12] = 2;
      x2[12] = 2.75;
      x3[12] = 2;
    end for;
  equation
    for i in 1:12 loop
      der(x1[i]) = -x2[i] ^ 5;
      der(x2[i]) = x1[i] + x2[i] ^ 2;
      der(x3[i]) = x3[i];
    end for;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
  end lab1_4var_9_fp;

  model lab2_32
    parameter Real K = 1;
    parameter Real k2 = 1;
    parameter Real k3 = 1;
    parameter Real k4 = 1;
    parameter Real d = 2;
    parameter Real b = 0.5;
    parameter Real a = 1;
    Real x(start = 0);
    Real v(start = 0);
    Real F;
  equation
    der(x) = v;
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    if x < (-d) then
      F = -K;
    elseif x < (-a) then
      F = 0.5 * x;
    elseif x < a then
      F = 0;
    elseif x < d then
      F = 0.5 * x;
    else
      F = K;
    end if;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
  end lab2_32;

  model lab2_31
    parameter Real K = 1;
    parameter Real k2 = 1;
    parameter Real k3 = 1;
    parameter Real k4 = 1;
    parameter Real b = 0.5;
    parameter Real a = 1;
    Real x(start = 0);
    Real v(start = 1);
    Real F;
    Real flag1(start = 0);
    Real flag2(start = 0);
  equation
    der(x) = v;
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    if flag1 < 0.5 then
      if x < (-b * a) then
        F = -K;
        flag1 = 0;
        flag2 = 0;
      else
        F = 0;
        flag1 = 1;
        flag2 = 0;
      end if;
    else
      if x > (-a) then
        if flag2 < 0.5 then
          if x < a then
            F = 0;
            flag2 = 0;
            flag1 = 1;
          else
            F = K;
            flag2 = 1;
            flag1 = 1;
          end if;
        else
          if x > b * a then
            F = K;
            flag2 = 1;
            flag1 = 1;
          else
            F = 0;
            flag2 = 0;
            flag1 = 1;
          end if;
        end if;
      else
        F = -K;
        flag1 = 0;
        flag2 = 0;
      end if;
    end if;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
  end lab2_31;

  model lab2test
    parameter Real K = 1;
    parameter Real k2 = 1;
    parameter Real k3 = 1;
    parameter Real k4 = 1;
    parameter Real a = 1;
    Real x(start = 0);
    Real v(start = 1);
    Real F;
    Real flag1(start = 0);
  equation
    der(x) = v;
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    if flag1 < 0.5 then
      if x < a then
        F = -K;
        flag1 = 0;
      else
        F = K;
        flag1 = 1;
      end if;
    else
      if x > (-a) then
        F = K;
        flag1 = 1;
      else
        F = -K;
        flag1 = 0;
      end if;
    end if;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
  end lab2test;

  model lab2_32b
    parameter Real K = 2;
    parameter Real k2 = 1;
    parameter Real k3 = 1;
    parameter Real k4 = 1;
    parameter Real a = 1;
    parameter Real b = 0.5;
    Real x(start = 0);
    Real v(start = 1);
    Real F;
    Real flag1(start = 0);
  equation
    der(x) = v;
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    if flag1 < 0.5 then
      if x < b then
        F = -K;
        flag1 = 0;
      elseif x < a then
        F = 2*K / (a-b) * x + K - (2*a*K / (a-b));
        flag1 = 0;
      else
        F = K;
        flag1 = 1;
      end if;
    else
      if x > (-b) then
        F = K;
        flag1 = 1;
      elseif x > (-a) then
        F = 2*K / (a-b) * x - K + (2*a*K / (a-b));
        flag1 = 1;
      else
        F = -K;
        flag1 = 0;
      end if;
    end if;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
  end lab2_32b;

  model lab3
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 2000)  annotation(
      Placement(visible = true, transformation(origin = {24, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R = 3000)  annotation(
      Placement(visible = true, transformation(origin = {24, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 220, f = 50)  annotation(
      Placement(visible = true, transformation(origin = {-38, 9}, extent = {{-10, -9}, {10, 9}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 0.0000001)  annotation(
      Placement(visible = true, transformation(origin = {70, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Zinchenko.my_resistor my_resistor(R = 2000)  annotation(
      Placement(visible = true, transformation(origin = {-18, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C = 0.0000001) annotation(
      Placement(visible = true, transformation(origin = {26, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(resistor1.n, capacitor1.n) annotation(
      Line(points = {{34, 12}, {34, 28}, {36, 28}, {36, 44}}, color = {0, 0, 255}));
  connect(capacitor1.p, resistor1.p) annotation(
      Line(points = {{16, 44}, {16, 28}, {14, 28}, {14, 12}}, color = {0, 0, 255}));
  connect(ground.p, sineVoltage.p) annotation(
      Line(points = {{-60, -30}, {-60, 26.5}, {-48, 26.5}, {-48, 9}}, color = {0, 0, 255}));
  connect(resistor2.p, sineVoltage.p) annotation(
      Line(points = {{14, -18}, {-48, -18}, {-48, 9}}, color = {0, 0, 255}));
  connect(sineVoltage.n, my_resistor.p) annotation(
      Line(points = {{-28, 10}, {-28, 44}}, color = {0, 0, 255}));
  connect(my_resistor.n, capacitor1.p) annotation(
      Line(points = {{-8, 44}, {16, 44}}, color = {0, 0, 255}));
  connect(capacitor1.n, capacitor.p) annotation(
      Line(points = {{36, 44}, {70, 44}, {70, 2}}, color = {0, 0, 255}));
  connect(capacitor.n, resistor2.n) annotation(
      Line(points = {{70, -18}, {34, -18}}, color = {0, 0, 255}));
    annotation(
      experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-6, Interval = 0.002),
      Diagram(coordinateSystem(extent = {{-80, 60}, {100, -60}})));end lab3;
  
  model my_resistor "Ideal linear electrical resistor"
    parameter Modelica.Units.SI.Resistance R(start = 1) "Resistance at temperature T_ref";
    parameter Modelica.Units.SI.Temperature T_ref = 300.15 "Reference temperature";
    parameter Modelica.Units.SI.LinearTemperatureCoefficient alpha = 100 "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
    parameter Modelica.Units.SI.Current i_0=1;
    parameter Modelica.Units.SI.Current i_max=0.003;
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
    Modelica.Units.SI.Resistance R_actual "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";
  equation
    assert(1 + alpha * (T_heatPort - T_ref) >= Modelica.Constants.eps, "Temperature outside scope of model!");
    if i>i_max then
      R_actual = R*(1 + alpha*(i_max^3/i_0));
    elseif i<-i_max then
      R_actual = R*(1 - alpha*(i_max^3/i_0));
    else
      R_actual = R*(1 + alpha*(i/i_0^3));
    end if;
    v = R_actual * i;
    LossPower = v * i;
    annotation(
      Documentation(info = "<html>
  <p>The linear resistor connects the branch voltage <em>v</em> with the branch current <em>i</em> by <em>i*R = v</em>. The Resistance <em>R</em> is allowed to be positive, zero, or negative.</p>
  </html>", revisions = "<html>
  <ul>
  <li><em> August 07, 2009   </em>
         by Anton Haumer<br> temperature dependency of resistance added<br>
         </li>
  <li><em> March 11, 2009   </em>
         by Christoph Clauss<br> conditional heat port added<br>
         </li>
  <li><em> 1998   </em>
         by Christoph Clauss<br> initially implemented<br>
         </li>
  </ul>
  </html>"),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-70, 30}, {70, -30}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-90, 0}, {-70, 0}}, color = {0, 0, 255}), Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), Text(extent = {{-150, -40}, {150, -80}}, textString = "R=%R"), Line(visible = useHeatPort, points = {{0, -100}, {0, -30}}, color = {127, 0, 0}, pattern = LinePattern.Dot), Text(extent = {{-150, 90}, {150, 50}}, textString = "%name", textColor = {0, 0, 255})}));
  end my_resistor;
  
  model lab3_2
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1500)  annotation(
      Placement(visible = true, transformation(origin = {62, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R = 2750)  annotation(
      Placement(visible = true, transformation(origin = {24, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 220, f = 50)  annotation(
      Placement(visible = true, transformation(origin = {-38, 9}, extent = {{-10, -9}, {10, 9}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C = 0.000001) annotation(
      Placement(visible = true, transformation(origin = {26, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 50)  annotation(
      Placement(visible = true, transformation(origin = {28, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor3(R = 3000)  annotation(
      Placement(visible = true, transformation(origin = {62, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Zinchenko.my_resistor2 my_resistor2 annotation(
      Placement(visible = true, transformation(origin = {-12, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor1.n, capacitor1.n) annotation(
      Line(points = {{72, 42}, {59, 42}, {59, 44}, {36, 44}}, color = {0, 0, 255}));
    connect(ground.p, sineVoltage.p) annotation(
      Line(points = {{-60, -30}, {-60, 26.5}, {-48, 26.5}, {-48, 9}}, color = {0, 0, 255}));
    connect(resistor2.p, sineVoltage.p) annotation(
      Line(points = {{14, -18}, {-48, -18}, {-48, 9}}, color = {0, 0, 255}));
    connect(capacitor1.p, inductor.p) annotation(
      Line(points = {{16, 44}, {18, 44}, {18, 16}}, color = {0, 0, 255}));
    connect(inductor.n, resistor3.p) annotation(
      Line(points = {{38, 16}, {52, 16}, {52, 18}}, color = {0, 0, 255}));
    connect(resistor1.n, resistor2.n) annotation(
      Line(points = {{72, 42}, {88, 42}, {88, -16}, {34, -16}, {34, -18}}, color = {0, 0, 255}));
    connect(resistor3.n, resistor2.n) annotation(
      Line(points = {{72, 18}, {82, 18}, {82, -48}, {34, -48}, {34, -18}}, color = {0, 0, 255}));
  connect(sineVoltage.n, my_resistor2.p) annotation(
      Line(points = {{-28, 10}, {-28, 44}, {-22, 44}}, color = {0, 0, 255}));
  connect(my_resistor2.n, capacitor1.p) annotation(
      Line(points = {{-2, 44}, {16, 44}}, color = {0, 0, 255}));
    annotation(
      experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-6, Interval = 0.002),
      Diagram(coordinateSystem(extent = {{-80, 60}, {100, -60}})));end lab3_2;
  
  model my_resistor2 "Ideal linear electrical resistor"
    parameter Modelica.Units.SI.Resistance R(start = 1) "Resistance at temperature T_ref";
    parameter Modelica.Units.SI.Temperature T_ref = 300.15 "Reference temperature";
    parameter Modelica.Units.SI.LinearTemperatureCoefficient alpha = 100 "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
    parameter Modelica.Units.SI.Current i_0=1;
    parameter Modelica.Units.SI.Current i_max=0.003;
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
    Modelica.Units.SI.Resistance R_actual "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";
  equation
    assert(1 + alpha * (T_heatPort - T_ref) >= Modelica.Constants.eps, "Temperature outside scope of model!");
    if i>=0 then
      R_actual = R*(1 + alpha*(i/i_0^2));
    else
      R_actual = R*(1 - alpha*(i/i_0^2));
    end if;
    v = R_actual * i;
    LossPower = v * i;
    annotation(
      Documentation(info = "<html>
  <p>The linear resistor connects the branch voltage <em>v</em> with the branch current <em>i</em> by <em>i*R = v</em>. The Resistance <em>R</em> is allowed to be positive, zero, or negative.</p>
  </html>", revisions = "<html>
  <ul>
  <li><em> August 07, 2009   </em>
         by Anton Haumer<br> temperature dependency of resistance added<br>
         </li>
  <li><em> March 11, 2009   </em>
         by Christoph Clauss<br> conditional heat port added<br>
         </li>
  <li><em> 1998   </em>
         by Christoph Clauss<br> initially implemented<br>
         </li>
  </ul>
  </html>"),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-70, 30}, {70, -30}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-90, 0}, {-70, 0}}, color = {0, 0, 255}), Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), Text(extent = {{-150, -40}, {150, -80}}, textString = "R=%R"), Line(visible = useHeatPort, points = {{0, -100}, {0, -30}}, color = {127, 0, 0}, pattern = LinePattern.Dot), Text(extent = {{-150, 90}, {150, 50}}, textString = "%name", textColor = {0, 0, 255})}));
  end my_resistor2;

  package KP_20221220
    extends Modelica.Units.SI; 
  
model Body2D
  parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
  parameter Real Color[3] = {0, 0, 255};
  Modelica.Units.SI.Length X;
  Modelica.Units.SI.Length Y;
  Modelica.Units.SI.Angle Phi;
  Outp Body_Out;
equation
  Body_Out.X = X;
  Body_Out.Y = Y;
  Body_Out.Phi = Phi;
end Body2D;

    connector Inp
      input Modelica.Units.SI.Angle Phi;
      input Modelica.Units.SI.Length X;
      input Modelica.Units.SI.Length Y;
    end Inp;

    connector Outp
      output Modelica.Units.SI.Angle Phi;
      output Modelica.Units.SI.Length X;
      output Modelica.Units.SI.Length Y;
    end Outp;

    model Rod2D
      extends Zinchenko.KP_20221220.Body2D;
      parameter Modelica.Units.SI.Length L = 1;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape Rodshape(shapeType = "box", length = L, width = 0.1, height = 0.1, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L/2*cos(Phi), Y - L/2 * sin(Phi), 0},R = orientation, r_shape = {0,0,0});
    
    equation
    
      
      
    end Rod2D;

model Model
  parameter Modelica.Units.SI.Length L1 = 1;
  parameter Modelica.Units.SI.Angle phi1 = 1.3;
  parameter Modelica.Units.SI.Angle phip = 1.57;
  parameter Modelica.Units.SI.Length XO = 0;
  parameter Modelica.Units.SI.Length YO = 0;
  parameter Modelica.Units.SI.Length XK = XO + L1*cos(phi1) + R*sin(phip);
  parameter Modelica.Units.SI.Length YK = YO + L1*sin(phi1);
  parameter Modelica.Units.SI.Length XD = XO + L1*cos(phi1);
  parameter Modelica.Units.SI.Length YD = YO + L1*sin(phi1);
  parameter Modelica.Units.SI.Length R = 1;
  Support2D Opora1(Xp = XO, Yp = YO, Xt = -L1/2, Yt = 0);
  Rod2D Palka1(Phi(start = phi1), L = L1, Color = {255, 165, 0});
equation
  connect(Palka1.Body_Out, Opora1.Body_In);
  der(Palka1.Phi) = 1;
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.00001));
end Model;

    model Support2D
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Length Xt = 0;
      parameter Modelica.Units.SI.Length Yt = 0;
      parameter Real Color[3] = {0, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape Wheelshape(shapeType = "cylinder", length = 0.5, width = 0.2, height = 0.2, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {Xp, Yp, -0.1}, R = orientation, r_shape = {0, 0, 0});
      Inp Body_In;
    equation
      Xp = Body_In.X + Xt * cos(Body_In.Phi) - Yt * sin(Body_In.Phi);
      Yp = Body_In.Y + Xt * sin(Body_In.Phi) + Yt * cos(Body_In.Phi);
    end Support2D;
  end KP_20221220;
  annotation(
    uses(Modelica(version = "4.0.0")));
end Zinchenko;
