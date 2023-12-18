package Electricity
  model Electr
    extends Modelica.Electrical;
    Modelica.Electrical.Analog.Basic.Resistor R1(R = 0.1) annotation(
      Placement(visible = true, transformation(origin = {18, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Basic.Resistor R2(R = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-18, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor C1(C = 10) annotation(
      Placement(visible = true, transformation(origin = {16, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Basic.Capacitor C2(C = 10) annotation(
      Placement(visible = true, transformation(origin = {72, -12}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-76, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 220, freqHz = 50) annotation(
      Placement(visible = true, transformation(origin = {-76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Basic.Resistor R0(R = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-66, 28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
    connect(ground.p, sineVoltage.p) annotation(
      Line(points = {{-76, -36}, {-76, -10}}, color = {0, 0, 255}));
    connect(ground.p, R2.p) annotation(
      Line(points = {{-76, -36}, {-28, -36}}, color = {0, 0, 255}));
    connect(R2.n, C2.p) annotation(
      Line(points = {{-8, -36}, {72, -36}, {72, -22}}, color = {0, 0, 255}));
    connect(C1.p, C2.n) annotation(
      Line(points = {{26, 28}, {72, 28}, {72, -2}}, color = {0, 0, 255}));
    connect(sineVoltage.n, R0.n) annotation(
      Line(points = {{-76, 10}, {-76, 28}}, color = {0, 0, 255}));
    connect(R0.p, C1.n) annotation(
      Line(points = {{-56, 28}, {6, 28}}, color = {0, 0, 255}));
    connect(R1.p, C2.n) annotation(
      Line(points = {{28, 6}, {72, 6}, {72, -2}}, color = {0, 0, 255}));
    connect(R1.n, C1.n) annotation(
      Line(points = {{8, 6}, {-12, 6}, {-12, 28}, {6, 28}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3")));
  end Electr;

  model Manual 
  extends Electricity.Electr; 
  Real i0;     //Ток в резисторе R0
  Real i1;     //Ток в резисторе R1
  Real i2;     //Ток в резисторе R2
  Real iC1;    //Ток в индукционной катушке L
  Real iC2;     //Ток в конденсаторе C
  Real v0;     //Напряжение в резисторе R0
  Real v1;     //Напряжение в резисторе R1
  Real v2;     //Напряжение в резисторе R2
  Real vC1;     //Напряжение в индукционной катушке L
  Real vC2;     //Напряжение в конденсаторе C
  equation 
  i0=iC1+i1; i0=iC1; iC1=i2;
  v0+vC1+vC2+v2=sineVoltage.v; vC1=v1;
  R0.R*i0=v0; R1.R*i1=v1; R2.R*i2=v2;
  C1.C*der(iC1)=vC1; C2.C*der(vC2)=iC2; 
  end Manual;

end Electricity;
