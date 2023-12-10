package Filippov_VDMCD_Labs
  package Lab_5
    model Body2D
      Modelica.Units.SI.Length X;
      Modelica.Units.SI.Length Y;
      Modelica.Units.SI.Angle Phi;
      KinematicOutput Body_Out;
    equation
      Body_Out.X = X;
      Body_Out.Y = Y;
      Body_Out.Phi = Phi;
    end Body2D;

    model Rod2D
      extends Filippov_VDMCD_Labs.Lab_5.Body2D;
      parameter Modelica.Units.SI.Length L = 1;
      parameter Real Color[3] = {0, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape RodShape(shapeType = "box", length = L, width = 0.2, height = 0.2, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L/2*cos(Phi), Y - L/2*sin(Phi), 0}, R = orientation, r_shape = {0, 0, 0});
    equation

    end Rod2D;

    model ProstoPalka
      Rod2D Palka;
    equation
      Palka.X = 0;
      Palka.Y = 0;
      Palka.Phi = sin(time);
    end ProstoPalka;

    model Support2D
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Length Xt = 0;
      parameter Modelica.Units.SI.Length Yt = 0;
      parameter Real Color[3] = {200, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SupportShape(shapeType = "cylinder", length = 0.5, width = 0.3, height = 0.3, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {Xp, Yp, 0}, R = orientation, r_shape = {0, 0, 0});
      KinematicInput Body_In;
    equation
      Xp = Body_In.X + Xt*cos(Body_In.Phi) - Yt*sin(Body_In.Phi);
      Yp = Body_In.Y + Xt*sin(Body_In.Phi) + Yt*cos(Body_In.Phi);
    end Support2D;

    connector KinematicInput
      input Modelica.Units.SI.Length X;
      input Modelica.Units.SI.Length Y;
      input Modelica.Units.SI.Angle Phi;
    end KinematicInput;

    connector KinematicOutput
      output Modelica.Units.SI.Length X;
      output Modelica.Units.SI.Length Y;
      output Modelica.Units.SI.Angle Phi;
    end KinematicOutput;

    model PalkaSOporoi
      parameter Modelica.Units.SI.Length L1 = 3;
      Rod2D Palka(L = L1);
      Support2D Opora(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
    equation
      connect(Opora.Body_In, Palka.Body_Out);
      Palka.Phi = sin(time);
    end PalkaSOporoi;

    model Wheel2D
      extends Filippov_VDMCD_Labs.Lab_5.Body2D;
      parameter Modelica.Units.SI.Length R = 1;
      parameter Real Color[3] = {0, 0, 200};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape WheelShape(shapeType = "cylinder", length = 0.2, width = 2*R, height = 2*R, lengthDirection = {0, 0, 1}, widthDirection = {cos(Phi), sin(Phi), 0}, color = Color, specularCoefficient = 0.5, r = {X, Y, 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape WheelCenterShape(shapeType = "box", length = 0.25, width = R, height = R, lengthDirection = {0, 0, 1}, widthDirection = {cos(Phi), sin(Phi), 0}, color = Color*0.7, specularCoefficient = 0.5, r = {X, Y, 0}, R = orientation, r_shape = {0, 0, 0});
    equation

    end Wheel2D;

    model KolesoSOporoi
      parameter Modelica.Units.SI.Length R1 = 3;
      Wheel2D Koleso(R = R1);
      Support2D Opora(Xp = 0, Yp = 2, Xt = -R1, Yt = 0);
    equation
      connect(Opora.Body_In, Koleso.Body_Out);
      Koleso.Phi = sin(time);
    end KolesoSOporoi;

    model Joint2D
      parameter Modelica.Units.SI.Length Xt1 = 0;
      parameter Modelica.Units.SI.Length Yt1 = 0;
      parameter Modelica.Units.SI.Length Xt2 = 0;
      parameter Modelica.Units.SI.Length Yt2 = 0;
      Modelica.Units.SI.Length XSh;
      Modelica.Units.SI.Length YSh;
      parameter Real Color[3] = {0, 200, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape JointShape(shapeType = "cylinder", length = 0.5, width = 0.3, height = 0.3, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {XSh, YSh, 0}, R = orientation, r_shape = {0, 0, 0});
      KinematicInput Body1_In;
      KinematicInput Body2_In;
    equation
      XSh = Body1_In.X + Xt1*cos(Body1_In.Phi) - Yt1*sin(Body1_In.Phi);
      YSh = Body1_In.Y + Xt1*sin(Body1_In.Phi) + Yt1*cos(Body1_In.Phi);
      XSh = Body2_In.X + Xt2*cos(Body2_In.Phi) - Yt2*sin(Body2_In.Phi);
      YSh = Body2_In.Y + Xt2*sin(Body2_In.Phi) + Yt2*cos(Body2_In.Phi);
    end Joint2D;

    model DvePalkiSOporoi
      parameter Modelica.Units.SI.Length L1 = 3;
      parameter Modelica.Units.SI.Length L2 = 5;
      Rod2D Palka1(L = L1, Color = {0, 100, 0});
      Support2D Opora(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
      Rod2D Palka2(L = L2, Color = {0, 0, 100});
      Joint2D Sharnir(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
    equation
      connect(Opora.Body_In, Palka1.Body_Out);
      connect(Sharnir.Body1_In, Palka1.Body_Out);
      connect(Sharnir.Body2_In, Palka2.Body_Out);
      Palka1.Phi = sin(time);
      Palka2.Phi = cos(time);
    end DvePalkiSOporoi;

    model TriPalki
      parameter Modelica.Units.SI.Length L1 = 3;
      parameter Modelica.Units.SI.Length L2 = 5;
      parameter Modelica.Units.SI.Length L3 = 6;
      Rod2D Palka1(L = L1, Color = {0, 100, 0});
      Support2D Opora1(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
      Rod2D Palka2(L = L2, Color = {0, 0, 100}, Phi(start = 2));
      Joint2D Sharnir1(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      Rod2D Palka3(L = L3, Color = {100, 0, 0});
      Joint2D Sharnir2(Xt1 = L2/2, Yt1 = 0, Xt2 = -L3/2, Yt2 = 0);
      Support2D Opora2(Xp = 5, Yp = 2, Xt = L3/2, Yt = 0);
    equation
      connect(Opora1.Body_In, Palka1.Body_Out);
      connect(Sharnir1.Body1_In, Palka1.Body_Out);
      connect(Sharnir1.Body2_In, Palka2.Body_Out);
      connect(Sharnir2.Body1_In, Palka2.Body_Out);
      connect(Sharnir2.Body2_In, Palka3.Body_Out);
      connect(Opora2.Body_In, Palka3.Body_Out);
      Palka1.Phi = time;
    end TriPalki;

    model Slider2D
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Angle Phip = 0;
      parameter Modelica.Units.SI.Length Xt = 0;
      parameter Modelica.Units.SI.Length Yt = 0;
      Modelica.Units.SI.Length S;
      parameter Real Color[3] = {0, 0, 200};
      parameter Modelica.Units.SI.Length Lp = 0.5;
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SliderPin(shapeType = "cylinder", length = 0.5, width = 0.3, height = 0.3, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {Xp + S*cos(Phip), Yp + S*sin(Phip), 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SliderShape(shapeType = "box", length = Lp, width = 0.5, height = 0.2, lengthDirection = {cos(Phip), sin(Phip), 0}, widthDirection = {-sin(Phip), cos(Phip), 0}, color = Color*0.7, specularCoefficient = 0.5, r = {Xp + (S - Lp/2)*cos(Phip), Yp + (S - Lp/2)*sin(Phip), 0}, R = orientation, r_shape = {0, 0, 0});
      KinematicInput Body_In;
    equation
      Xp + S*cos(Phip) = Body_In.X + Xt*cos(Body_In.Phi) - Yt*sin(Body_In.Phi);
      Yp + S*sin(Phip) = Body_In.Y + Xt*sin(Body_In.Phi) + Yt*cos(Body_In.Phi);
    end Slider2D;

    model DvePalkiSPolzunom
      parameter Modelica.Units.SI.Length L1 = 2;
      parameter Modelica.Units.SI.Length L2 = 5;
      Rod2D Palka1(L = L1, Color = {0, 100, 0});
      Support2D Opora(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
      Rod2D Palka2(L = L2, Color = {0, 0, 100});
      Joint2D Sharnir(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      Slider2D Polzun(Xp = 0, Yp = 2, Phip = 0, Xt = L2/2, Yt = 0);
    equation
      connect(Opora.Body_In, Palka1.Body_Out);
      connect(Sharnir.Body1_In, Palka1.Body_Out);
      connect(Sharnir.Body2_In, Palka2.Body_Out);
      connect(Polzun.Body_In, Palka2.Body_Out);
      Palka1.Phi = time;
    end DvePalkiSPolzunom;

    model RollCircleOnLine
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Angle Phip = 0;
      parameter Modelica.Units.SI.Length R = 1;
      Modelica.Units.SI.Length S;
      parameter Real Color[3] = {0, 0, 150};
      parameter Modelica.Units.SI.Length Lp = 6 * R;
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape LineShape(shapeType = "box", length = Lp, width = 0.5, height = 0.2, lengthDirection = {cos(Phip), sin(Phip), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {Xp - Lp / 2 * cos(Phip) + 0.1 * sin(Phip), Yp - Lp / 2 * sin(Phip) - 0.1 * cos(Phip), 0}, R = orientation, r_shape = {0, 0, 0});
      KinematicInput Body_In;
    equation
      Xp + S * cos(Phip) = Body_In.X + R * sin(Phip);
      Yp + S * sin(Phip) = Body_In.Y - R * cos(Phip);
      der(S) = -der(Body_In.Phi) * R;
    end RollCircleOnLine;

    model DvePalkiSKolesom
      parameter Modelica.Units.SI.Length L1 = 2;
      parameter Modelica.Units.SI.Length L2 = 5;
      parameter Modelica.Units.SI.Length R = 0.5;
      Rod2D Palka1(L = L1, Color = {0, 150, 0});
      Support2D Opora(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
      Rod2D Palka2(L = L2, Color = {0, 0, 150});
      Joint2D Sharnir1(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      Wheel2D Koleso(R = R, Color = {150, 0, 0});
      Joint2D Sharnir2(Xt1 = L2/2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      RollCircleOnLine Kachenie(Xp = L1 + L2, Yp = 2 - R, Phip = 0, R = R);
    equation
      connect(Opora.Body_In, Palka1.Body_Out);
      connect(Sharnir1.Body1_In, Palka1.Body_Out);
      connect(Sharnir1.Body2_In, Palka2.Body_Out);
      connect(Sharnir2.Body1_In, Palka2.Body_Out);
      connect(Sharnir2.Body2_In, Koleso.Body_Out);
      connect(Kachenie.Body_In, Koleso.Body_Out);
      Palka1.Phi = time;
    end DvePalkiSKolesom;

    model Var_5
      parameter Modelica.Units.SI.Length L1 = 1;
      parameter Modelica.Units.SI.Length L2 = 3;
      parameter Modelica.Units.SI.Length L3 = 3;
      parameter Modelica.Units.SI.Length L4 = 3;
      parameter Modelica.Units.SI.Length R = 1;
      parameter Modelica.Units.SI.Angle phi10 = 0.52;
      parameter Modelica.Units.SI.Angle phi20 = 5.24;
      parameter Modelica.Units.SI.Angle phi30 = 4.36;
      parameter Modelica.Units.SI.Angle phi40 = 3.32;
      parameter Modelica.Units.SI.Angle phip = 0;
      parameter Modelica.Units.SI.Length X0 = 15;
      parameter Modelica.Units.SI.Length Y0 = 15;
      parameter Modelica.Units.SI.Length XE = X0 + L1*cos(phi10) - L2*cos(phi20) - L3*cos(phi30);
      parameter Modelica.Units.SI.Length YE = Y0 + L1*sin(phi10) + L2*sin(phi20) + L3*sin(phi30);
      parameter Modelica.Units.SI.Length XK = X0 + L1*cos(phi10) - L2*cos(phi20) - L3/2*cos(phi30) + L4*cos(phi40) + R*sin(phip);
      parameter Modelica.Units.SI.Length YK = Y0 + L1*sin(phi10) + L2*sin(phi20) + L3/2*sin(phi30) + L4*sin(phi40) - R*cos(phip);
      Rod2D Palka1(L = L1, Color = {0, 150, 0}, Phi(start = phi10));
      Rod2D Palka2(L = L2, Color = {0, 0, 150}, Phi(start = phi20));
      Rod2D Palka3(L = L3, Color = {0, 0, 150}, Phi(start = phi30));
      Rod2D Palka4(L = L4, Color = {0, 0, 150}, Phi(start = phi40));
      Wheel2D Koleso(R = R, Color = {150, 0, 0});
      Support2D Opora1(Xp = X0, Yp = Y0, Xt = -L1/2, Yt = 0);
      Support2D Opora2(Xp = XE, Yp = YE, Xt = L3/2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2/2, Yt1 = 0, Xt2 = -L3/2, Yt2 = 0);
      Joint2D Sharnir3(Xt1 = 0, Yt1 = 0, Xt2 = -L4/2, Yt2 = 0);
      Joint2D Sharnir4(Xt1 = L4/2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      RollCircleOnLine Kachenie(Xp = XK, Yp = YK, Phip = phip, R = R);
    equation
      connect(Opora1.Body_In, Palka1.Body_Out);
      connect(Sharnir1.Body1_In, Palka1.Body_Out);
      connect(Sharnir1.Body2_In, Palka2.Body_Out);
      connect(Sharnir2.Body1_In, Palka2.Body_Out);
      connect(Sharnir2.Body2_In, Palka3.Body_Out);
      connect(Opora2.Body_In, Palka3.Body_Out);
      connect(Sharnir3.Body1_In, Palka3.Body_Out);
      connect(Sharnir3.Body2_In, Palka4.Body_Out);
      connect(Sharnir4.Body1_In, Palka4.Body_Out);
      connect(Sharnir4.Body2_In, Koleso.Body_Out);
      connect(Kachenie.Body_In, Koleso.Body_Out);
      Palka1.Phi = time;
    end Var_5;

    model Var_5_Proverka
      parameter Modelica.Units.SI.Length L1 = 1;
      parameter Modelica.Units.SI.Length L2 = 3;
      parameter Modelica.Units.SI.Length L3 = 4;
      parameter Modelica.Units.SI.Length L4 = 3;
      parameter Modelica.Units.SI.Length R = 1;
      parameter Modelica.Units.SI.Angle phi10 = 0.52;
      parameter Modelica.Units.SI.Angle phi20 = 5.24;
      parameter Modelica.Units.SI.Angle phi30 = 4.36;
      parameter Modelica.Units.SI.Angle phi40 = 3.32;
      parameter Modelica.Units.SI.Angle phip = 0;
      parameter Modelica.Units.SI.Length X0 = 15;
      parameter Modelica.Units.SI.Length Y0 = 15;
      parameter Modelica.Units.SI.Length XE = X0 + L1*cos(phi10) + L2*cos(phi20) + L3*cos(phi30);
      parameter Modelica.Units.SI.Length YE = Y0 + L1*sin(phi10) + L2*sin(phi20) + L3*sin(phi30);
      parameter Modelica.Units.SI.Length XK = X0 + L1*cos(phi10) + L2*cos(phi20) + L3/2*cos(phi30) + L4*cos(phi40) + R*sin(phip);
      parameter Modelica.Units.SI.Length YK = Y0 + L1*sin(phi10) + L2*sin(phi20) + L3/2*sin(phi30) + L4*sin(phi40) - R*cos(phip);
      Rod2D Palka1(L = L1, Color = {0, 150, 0}, Phi(start = phi10));
      Rod2D Palka2(L = L2, Color = {0, 0, 150}, Phi(start = phi20));
      Rod2D Palka3(L = L3, Color = {0, 0, 150}, Phi(start = phi30));
      Rod2D Palka4(L = L4, Color = {0, 0, 150}, Phi(start = phi40));
      Wheel2D Koleso(R = R, Color = {150, 0, 0});
      Support2D Opora1(Xp = X0, Yp = Y0, Xt = -L1/2, Yt = 0);
      Support2D Opora2(Xp = XE, Yp = YE, Xt = L3/2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2/2, Yt1 = 0, Xt2 = -L3/2, Yt2 = 0);
      Joint2D Sharnir3(Xt1 = 0, Yt1 = 0, Xt2 = -L4/2, Yt2 = 0);
      Joint2D Sharnir4(Xt1 = L4/2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      RollCircleOnLine Kachenie(Xp = XK, Yp = YK, Phip = phip, R = R);
    equation
      connect(Opora1.Body_In, Palka1.Body_Out);
      connect(Sharnir1.Body1_In, Palka1.Body_Out);
      connect(Sharnir1.Body2_In, Palka2.Body_Out);
      connect(Sharnir2.Body1_In, Palka2.Body_Out);
      connect(Sharnir2.Body2_In, Palka3.Body_Out);
      connect(Opora2.Body_In, Palka3.Body_Out);
      connect(Sharnir3.Body1_In, Palka3.Body_Out);
      connect(Sharnir3.Body2_In, Palka4.Body_Out);
      connect(Sharnir4.Body1_In, Palka4.Body_Out);
      connect(Sharnir4.Body2_In, Koleso.Body_Out);
      connect(Kachenie.Body_In, Koleso.Body_Out);
      Palka1.Phi = time;
    end Var_5_Proverka;

    model RollCircleOnCircle
    
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Angle Phip = 0;
      parameter Modelica.Units.SI.Length R = 1;
      Modelica.Units.SI.Length S;
      parameter Real Color[3] = {0, 0, 150};
      parameter Modelica.Units.SI.Length Lp = 6*R;
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape CircleShape(shapeType = "cylinder", length = 0.2, width = Lp*2, height = Lp*2, lengthDirection = {0, 0, 1}, widthDirection = {cos(Phip), sin(Phip), 0}, color = Color, specularCoefficient = 0.5, r = {Xp, Yp, 0}, R = orientation, r_shape = {0, 0, 0});
      
      KinematicInput Body_In;
    equation
    
      Xp = Body_In.X + (Lp+R)*cos(-Body_In.Phi);
      Yp = Body_In.Y + (Lp+R)*sin(-Body_In.Phi);
      der(S) = der(Body_In.Phi)*R;
      
    end RollCircleOnCircle;

    model WheelOnCircle
    
      parameter Modelica.Units.SI.Length R1 = 2;
      //parameter Modelica.Units.SI.Length R2 = 5;
      parameter Modelica.Units.SI.Length L1 = 2;
      
      //Rod2D Palka(L = R1, Color = {0, 150, 0});
      //Support2D Opora(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
      //Joint2D Sharnir(Xt1 = L1/2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      Wheel2D Koleso(R = R1, Color = {150, 0, 0});
      RollCircleOnCircle Kachenie(Xp = 0, Yp = 2, R = R1);
      
    equation
    
      //connect(Opora.Body_In, Palka.Body_Out);
      //connect(Sharnir.Body1_In, Palka.Body_Out);
      //connect(Sharnir.Body2_In, Koleso.Body_Out);
      connect(Kachenie.Body_In, Koleso.Body_Out);
      Koleso.Phi = time;
      
    end WheelOnCircle;

    model Mechanism
    
      parameter Modelica.Units.SI.Length R1 = 3;
      Wheel2D Koleso(R = R1);
      Support2D Opora(Xp = 0, Yp = 2, Xt = 0, Yt = 0);
    equation
      connect(Opora.Body_In, Koleso.Body_Out);
      Koleso.Phi = -time;

    end Mechanism;
  end Lab_5;

  package Lab_6
    model TwoPortBody2D
      parameter Modelica.Units.SI.Mass m = 1;
      parameter Modelica.Units.SI.Acceleration g = 9.81;
      Modelica.Units.SI.MomentOfInertia J;
      Modelica.Units.SI.Length X;
      Modelica.Units.SI.Length Y;
      Modelica.Units.SI.Angle Phi;
      Modelica.Units.SI.Velocity Vx(start = 0);
      Modelica.Units.SI.Velocity Vy(start = 0);
      Modelica.Units.SI.AngularVelocity Omega(start = 0);
      Modelica.Units.SI.Acceleration Wx(start = 0);
      Modelica.Units.SI.Acceleration Wy(start = 0);
      Modelica.Units.SI.AngularAcceleration Epsilon(start = 0);
      KinematicOutput Body_Out;
      DynamicInput F_A;
      DynamicInput F_B;
    equation
      der(X) = Vx;
      der(Y) = Vy;
      der(Phi) = Omega;
      der(Vx) = Wx;
      der(Vy) = Wy;
      der(Omega) = Epsilon;
      m*Wx = F_A.Fx + F_B.Fx;
      m*Wy = (-m*g) + F_A.Fy + F_B.Fy;
      J*Epsilon = (F_A.X - X)*F_A.Fy - (F_A.Y - Y)*F_A.Fx + F_A.M + (F_B.X - X)*F_B.Fy - (F_B.Y - Y)*F_B.Fx + F_B.M;
      Body_Out.X = X;
      Body_Out.Y = Y;
      Body_Out.Phi = Phi;
    end TwoPortBody2D;

    model TwoPortWheel2D
      extends Filippov_VDMCD_Labs.Lab_6.TwoPortBody2D;
      parameter Modelica.Units.SI.Length R = 1;
      parameter Real Color[3] = {0, 0, 200};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape WheelShape(shapeType = "cylinder", length = 0.2, width = 2*R, height = 2*R, lengthDirection = {0, 0, 1}, widthDirection = {cos(Phi), sin(Phi), 0}, color = Color, specularCoefficient = 0.5, r = {X, Y, 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape WheelCenterShape(shapeType = "box", length = 0.25, width = R, height = R, lengthDirection = {0, 0, 1}, widthDirection = {cos(Phi), sin(Phi), 0}, color = Color*0.7, specularCoefficient = 0.5, r = {X, Y, 0}, R = orientation, r_shape = {0, 0, 0});
    equation
      J = m*R^2/2;
    end TwoPortWheel2D;

    connector KinematicInput
      input Modelica.Units.SI.Length X;
      input Modelica.Units.SI.Length Y;
      input Modelica.Units.SI.Angle Phi;
    end KinematicInput;

    connector KinematicOutput
      output Modelica.Units.SI.Length X;
      output Modelica.Units.SI.Length Y;
      output Modelica.Units.SI.Angle Phi;
    end KinematicOutput;

    connector DynamicInput
      input Modelica.Units.SI.Length X;
      input Modelica.Units.SI.Length Y;
      input Modelica.Units.SI.Force Fx;
      input Modelica.Units.SI.Force Fy;
      input Modelica.Units.SI.MomentOfForce M;
    end DynamicInput;

    connector DynamicOutput
      output Modelica.Units.SI.Length X;
      output Modelica.Units.SI.Length Y;
      output Modelica.Units.SI.Force Fx;
      output Modelica.Units.SI.Force Fy;
      output Modelica.Units.SI.MomentOfForce M;
    end DynamicOutput;

    model FreePoint2D
      //Точка с нулём
      DynamicOutput F_Out;
    equation
      F_Out.X = 0;
      F_Out.Y = 0;
      F_Out.Fx = 0;
      F_Out.Fy = 0;
      F_Out.M = 0;
    end FreePoint2D;

    model Support2D
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Length Xt = 0;
      parameter Modelica.Units.SI.Length Yt = 0;
      parameter Real Color[3] = {200, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SupportShape(shapeType = "cylinder", length = 0.5, width = 0.3, height = 0.3, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {Xp, Yp, 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Units.SI.Force Rx;
      Modelica.Units.SI.Force Ry;
      KinematicInput Body_In;
      DynamicOutput F_Out;
    equation
      Xp = Body_In.X + Xt*cos(Body_In.Phi) - Yt*sin(Body_In.Phi);
      Yp = Body_In.Y + Xt*sin(Body_In.Phi) + Yt*cos(Body_In.Phi);
      F_Out.X = Xp;
      F_Out.Y = Yp;
      F_Out.Fx = Rx;
      F_Out.Fy = Ry;
      F_Out.M = 0;
    end Support2D;

    model PalkaSOporoi
      parameter Modelica.Units.SI.Length L1 = 3;
      TwoPortRod2D Palka(L = L1, Omega(start = 3.13));
      Support2D Opora(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
      FreePoint2D Xvost;
    equation
      connect(Opora.Body_In, Palka.Body_Out);
      connect(Opora.F_Out, Palka.F_A);
      connect(Xvost.F_Out, Palka.F_B);
    end PalkaSOporoi;

    model TwoPortRod2D
      extends Filippov_VDMCD_Labs.Lab_6.TwoPortBody2D;
      parameter Modelica.Units.SI.Length L = 1;
      parameter Real Color[3] = {0, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape RodShape(shapeType = "box", length = L, width = 0.2, height = 0.2, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L/2*cos(Phi), Y - L/2*sin(Phi), 0}, R = orientation, r_shape = {0, 0, 0});
    equation
      J = m*L^2/12;
    end TwoPortRod2D;

    model Joint2D
      parameter Modelica.Units.SI.Length Xt1 = 0;
      parameter Modelica.Units.SI.Length Yt1 = 0;
      parameter Modelica.Units.SI.Length Xt2 = 0;
      parameter Modelica.Units.SI.Length Yt2 = 0;
      Modelica.Units.SI.Length XSh;
      Modelica.Units.SI.Length YSh;
      parameter Real Color[3] = {0, 200, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape JointShape(shapeType = "cylinder", length = 0.5, width = 0.3, height = 0.3, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {XSh, YSh, 0}, R = orientation, r_shape = {0, 0, 0});
      KinematicInput Body1_In;
      KinematicInput Body2_In;
      Modelica.Units.SI.Force Rx;
      Modelica.Units.SI.Force Ry;
      DynamicOutput F1_Out;
      DynamicOutput F2_Out;
    equation
      XSh = Body1_In.X + Xt1*cos(Body1_In.Phi) - Yt1*sin(Body1_In.Phi);
      YSh = Body1_In.Y + Xt1*sin(Body1_In.Phi) + Yt1*cos(Body1_In.Phi);
      XSh = Body2_In.X + Xt2*cos(Body2_In.Phi) - Yt2*sin(Body2_In.Phi);
      YSh = Body2_In.Y + Xt2*sin(Body2_In.Phi) + Yt2*cos(Body2_In.Phi);
      F1_Out.X = XSh;
      F1_Out.Y = YSh;
      F1_Out.Fx = Rx;
      F1_Out.Fy = Ry;
      F1_Out.M = 0;
      F2_Out.X = XSh;
      F2_Out.Y = YSh;
      F2_Out.Fx = -Rx;
      F2_Out.Fy = -Ry;
      F2_Out.M = 0;
    end Joint2D;

    model DvePalkiSOporoi
      parameter Modelica.Units.SI.Length L1 = 3;
      parameter Modelica.Units.SI.Length L2 = 1;
      parameter Modelica.Units.SI.Mass m1 = 1;
      parameter Modelica.Units.SI.Mass m2 = 1000;
      TwoPortRod2D Palka1(L = L1, Color = {0, 100, 0}, m = m1, Phi(start = -1));
      Support2D Opora(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
      TwoPortRod2D Palka2(L = L2, Color = {0, 0, 100}, m = m2, Phi(start = -2));
      Joint2D Sharnir(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      FreePoint2D Xvost;
    equation
      connect(Opora.Body_In, Palka1.Body_Out);
      connect(Sharnir.Body1_In, Palka1.Body_Out);
      connect(Sharnir.Body2_In, Palka2.Body_Out);
      connect(Opora.F_Out, Palka1.F_A);
      connect(Sharnir.F1_Out, Palka1.F_B);
      connect(Sharnir.F2_Out, Palka2.F_A);
      connect(Xvost.F_Out, Palka2.F_B);
    end DvePalkiSOporoi;

    model Slider2D
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Angle Phip = 0;
      parameter Modelica.Units.SI.Length Xt = 0;
      parameter Modelica.Units.SI.Length Yt = 0;
      Modelica.Units.SI.Length S;
      parameter Real Color[3] = {0, 0, 200};
      parameter Modelica.Units.SI.Length Lp = 0.5;
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SliderPin(shapeType = "cylinder", length = 0.5, width = 0.3, height = 0.3, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {Xp + S*cos(Phip), Yp + S*sin(Phip), 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SliderShape(shapeType = "box", length = Lp, width = 0.5, height = 0.2, lengthDirection = {cos(Phip), sin(Phip), 0}, widthDirection = {-sin(Phip), cos(Phip), 0}, color = Color*0.7, specularCoefficient = 0.5, r = {Xp + (S - Lp/2)*cos(Phip), Yp + (S - Lp/2)*sin(Phip), 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Units.SI.Length XPol;
      Modelica.Units.SI.Length YPol;
      KinematicInput Body_In;
      Modelica.Units.SI.Force N;
      DynamicOutput F_Out;
    equation
      XPol = Xp + S*cos(Phip);
      YPol = Yp + S*sin(Phip);
      XPol = Body_In.X + Xt*cos(Body_In.Phi) - Yt*sin(Body_In.Phi);
      YPol = Body_In.Y + Xt*sin(Body_In.Phi) + Yt*cos(Body_In.Phi);
      F_Out.X = XPol;
      F_Out.Y = YPol;
      F_Out.Fx = -N*sin(Phip);
      F_Out.Fy = N*cos(Phip);
      F_Out.M = 0;
    end Slider2D;

    model DvePalkiSPolzunom
      parameter Modelica.Units.SI.Length L1 = 2;
      parameter Modelica.Units.SI.Length L2 = 5;
      parameter Modelica.Units.SI.Mass m1 = 1;
      parameter Modelica.Units.SI.Mass m2 = 10;
      TwoPortRod2D Palka1(L = L1, Color = {0, 100, 0}, m = m1, Omega(start = 5));
      Support2D Opora(Xp = 0, Yp = 2, Xt = -L1/2, Yt = 0);
      TwoPortRod2D Palka2(L = L2, Color = {0, 0, 100}, m = m2);
      Joint2D Sharnir(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      Slider2D Polzun(Xp = L1 + L2, Yp = 2, Phip = 0, Xt = L2/2, Yt = 0);
    equation
      connect(Opora.Body_In, Palka1.Body_Out);
      connect(Sharnir.Body1_In, Palka1.Body_Out);
      connect(Sharnir.Body2_In, Palka2.Body_Out);
      connect(Polzun.Body_In, Palka2.Body_Out);
      connect(Opora.F_Out, Palka1.F_A);
      connect(Sharnir.F1_Out, Palka1.F_B);
      connect(Sharnir.F2_Out, Palka2.F_A);
      connect(Polzun.F_Out, Palka2.F_B);
    end DvePalkiSPolzunom;

    model RollCircleOnLine
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Angle Phip = 0;
      parameter Modelica.Units.SI.Length R = 1;
      Modelica.Units.SI.Length S;
      parameter Real Color[3] = {0, 0, 150};
      parameter Modelica.Units.SI.Length Lp = 6*R;
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape LineShape(shapeType = "box", length = Lp, width = 0.5, height = 0.2, lengthDirection = {cos(Phip), sin(Phip), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {Xp - Lp/2*cos(Phip) + 0.1*sin(Phip), Yp - Lp/2*sin(Phip) - 0.1*cos(Phip), 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Units.SI.Length XPol;
      Modelica.Units.SI.Length YPol;
      KinematicInput Body_In;
      Modelica.Units.SI.Force N;
      Modelica.Units.SI.Force Ftr;
      DynamicOutput F_Out;
    equation
      XPol = Xp + S*cos(Phip);
      YPol = Yp + S*sin(Phip);
      XPol = Body_In.X + R*sin(Phip);
      YPol = Body_In.Y - R*cos(Phip);
      der(S) = -der(Body_In.Phi)*R;
      F_Out.X = XPol;
      F_Out.Y = YPol;
      F_Out.Fx = -N*sin(Phip) - Ftr*cos(Phip);
      F_Out.Fy = N*cos(Phip) - Ftr*sin(Phip);
      F_Out.M = 0;
    end RollCircleOnLine;

    model Var_5
      parameter Modelica.Units.SI.Length L1 = 1;
      parameter Modelica.Units.SI.Length L2 = 3;
      parameter Modelica.Units.SI.Length L3 = 4;
      parameter Modelica.Units.SI.Length L4 = 3;
      parameter Modelica.Units.SI.Length R = 1;
      parameter Modelica.Units.SI.Mass m1 = 1;
      parameter Modelica.Units.SI.Mass m2 = 3;
      parameter Modelica.Units.SI.Mass m3 = 6;
      parameter Modelica.Units.SI.Mass m4 = 4;
      parameter Modelica.Units.SI.Mass m5 = 3;
      parameter Modelica.Units.SI.Angle phi10 = 0.52;
      parameter Modelica.Units.SI.Angle phi20 = 5.24;
      parameter Modelica.Units.SI.Angle phi30 = 4.36;
      parameter Modelica.Units.SI.Angle phi40 = 3.32;
      parameter Modelica.Units.SI.Angle phip = 0;
      parameter Modelica.Units.SI.Length X0 = 15;
      parameter Modelica.Units.SI.Length Y0 = 15;
      parameter Modelica.Units.SI.Length XE = X0 + L1*cos(phi10) + L2*cos(phi20) + L3*cos(phi30);
      parameter Modelica.Units.SI.Length YE = Y0 + L1*sin(phi10) + L2*sin(phi20) + L3*sin(phi30);
      parameter Modelica.Units.SI.Length XK = X0 + L1*cos(phi10) + L2*cos(phi20) + L3/2*cos(phi30) + L4*cos(phi40) + R*sin(phip);
      parameter Modelica.Units.SI.Length YK = Y0 + L1*sin(phi10) + L2*sin(phi20) + L3/2*sin(phi30) + L4*sin(phi40) - R*cos(phip);
      TwoPortRod2D Palka1(L = L1, Color = {0, 150, 0}, Phi(start = phi10), m = m1);
      TwoPortRod2D Palka2(L = L2, Color = {0, 0, 150}, Phi(start = phi20), m = m2);
      ThreePortRod2D Palka3(L = L3, Color = {0, 0, 150}, Phi(start = phi30), m = m3);
      TwoPortRod2D Palka4(L = L4, Color = {0, 0, 150}, Phi(start = phi40), m = m4);
      TwoPortWheel2D Koleso(R = R, Color = {150, 0, 0}, m = m5);
      Support2D Opora1(Xp = X0, Yp = Y0, Xt = -L1/2, Yt = 0);
      Support2D Opora2(Xp = XE, Yp = YE, Xt = L3/2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2/2, Yt1 = 0, Xt2 = -L3/2, Yt2 = 0);
      Joint2D Sharnir3(Xt1 = 0, Yt1 = 0, Xt2 = -L4/2, Yt2 = 0);
      Joint2D Sharnir4(Xt1 = L4/2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      RollCircleOnLine Kachenie(Xp = XK, Yp = YK, Phip = phip, R = R);
    equation
      connect(Opora1.Body_In, Palka1.Body_Out);
      connect(Sharnir1.Body1_In, Palka1.Body_Out);
      connect(Sharnir1.Body2_In, Palka2.Body_Out);
      connect(Sharnir2.Body1_In, Palka2.Body_Out);
      connect(Sharnir2.Body2_In, Palka3.Body_Out);
      connect(Opora2.Body_In, Palka3.Body_Out);
      connect(Sharnir3.Body1_In, Palka3.Body_Out);
      connect(Sharnir3.Body2_In, Palka4.Body_Out);
      connect(Sharnir4.Body1_In, Palka4.Body_Out);
      connect(Sharnir4.Body2_In, Koleso.Body_Out);
      connect(Kachenie.Body_In, Koleso.Body_Out);
      connect(Opora1.F_Out, Palka1.F_A);
      connect(Sharnir1.F1_Out, Palka1.F_B);
      connect(Sharnir1.F2_Out, Palka2.F_A);
      connect(Sharnir2.F1_Out, Palka2.F_B);
      connect(Sharnir2.F2_Out, Palka3.F_A);
      connect(Opora2.F_Out, Palka3.F_C);
      connect(Sharnir3.F1_Out, Palka3.F_B);
      connect(Sharnir3.F2_Out, Palka4.F_A);
      connect(Sharnir4.F1_Out, Palka4.F_B);
      connect(Sharnir4.F2_Out, Koleso.F_A);
      connect(Kachenie.F_Out, Koleso.F_B);
    end Var_5;

    model FourPortBody2D
      parameter Modelica.Units.SI.Mass m = 1;
      parameter Modelica.Units.SI.Acceleration g = 9.81;
      Modelica.Units.SI.MomentOfInertia J;
      Modelica.Units.SI.Length X;
      Modelica.Units.SI.Length Y;
      Modelica.Units.SI.Angle Phi;
      Modelica.Units.SI.Velocity Vx(start = 0);
      Modelica.Units.SI.Velocity Vy(start = 0);
      Modelica.Units.SI.AngularVelocity Omega(start = 0);
      Modelica.Units.SI.Acceleration Wx(start = 0);
      Modelica.Units.SI.Acceleration Wy(start = 0);
      Modelica.Units.SI.AngularAcceleration Epsilon(start = 0);
      KinematicOutput Body_Out;
      DynamicInput F_A;
      DynamicInput F_B;
      DynamicInput F_C;
      DynamicInput F_D;
    equation
      der(X) = Vx;
      der(Y) = Vy;
      der(Phi) = Omega;
      der(Vx) = Wx;
      der(Vy) = Wy;
      der(Omega) = Epsilon;
      m*Wx = F_A.Fx + F_B.Fx + F_C.Fx + F_D.Fx;
      m*Wy = (-m*g) + F_A.Fy + F_B.Fy + F_C.Fy + F_D.Fy;
      J*Epsilon = (F_A.X - X)*F_A.Fy - (F_A.Y - Y)*F_A.Fx + F_A.M + (F_B.X - X)*F_B.Fy - (F_B.Y - Y)*F_B.Fx + F_B.M + (F_C.X - X)*F_C.Fy - (F_C.Y - Y)*F_C.Fx + F_C.M + (F_D.X - X)*F_D.Fy - (F_D.Y - Y)*F_D.Fx + F_D.M;
      Body_Out.X = X;
      Body_Out.Y = Y;
      Body_Out.Phi = Phi;
    end FourPortBody2D;

    model FourPortRod2D
      extends Filippov_VDMCD_Labs.Lab_6.FourPortBody2D;
      parameter Modelica.Units.SI.Length L = 1;
      parameter Real Color[3] = {0, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape RodShape(shapeType = "box", length = L, width = 0.2, height = 0.2, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L/2*cos(Phi), Y - L/2*sin(Phi), 0}, R = orientation, r_shape = {0, 0, 0});
    equation
      J = m*L^2/12;
    end FourPortRod2D;

    model ThreePortBody2D
      parameter Modelica.Units.SI.Mass m = 1;
      parameter Modelica.Units.SI.Acceleration g = 9.81;
      Modelica.Units.SI.MomentOfInertia J;
      Modelica.Units.SI.Length X;
      Modelica.Units.SI.Length Y;
      Modelica.Units.SI.Angle Phi;
      Modelica.Units.SI.Velocity Vx(start = 0);
      Modelica.Units.SI.Velocity Vy(start = 0);
      Modelica.Units.SI.AngularVelocity Omega(start = 0);
      Modelica.Units.SI.Acceleration Wx(start = 0);
      Modelica.Units.SI.Acceleration Wy(start = 0);
      Modelica.Units.SI.AngularAcceleration Epsilon(start = 0);
      KinematicOutput Body_Out;
      DynamicInput F_A;
      DynamicInput F_B;
      DynamicInput F_C;
    equation
      der(X) = Vx;
      der(Y) = Vy;
      der(Phi) = Omega;
      der(Vx) = Wx;
      der(Vy) = Wy;
      der(Omega) = Epsilon;
      m*Wx = F_A.Fx + F_B.Fx + F_C.Fx;
      m*Wy = (-m*g) + F_A.Fy + F_B.Fy + F_C.Fy;
      J*Epsilon = (F_A.X - X)*F_A.Fy - (F_A.Y - Y)*F_A.Fx + F_A.M + (F_B.X - X)*F_B.Fy - (F_B.Y - Y)*F_B.Fx + F_B.M + (F_C.X - X)*F_C.Fy - (F_C.Y - Y)*F_C.Fx + F_C.M;
      Body_Out.X = X;
      Body_Out.Y = Y;
      Body_Out.Phi = Phi;
    end ThreePortBody2D;

    model ThreePortRod2D
      extends Filippov_VDMCD_Labs.Lab_6.ThreePortBody2D;
      parameter Modelica.Units.SI.Length L = 1;
      parameter Real Color[3] = {0, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape RodShape(shapeType = "box", length = L, width = 0.2, height = 0.2, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L/2*cos(Phi), Y - L/2*sin(Phi), 0}, R = orientation, r_shape = {0, 0, 0});
    equation
      J = m*L^2/12;
    end ThreePortRod2D;

    model RustSupport2D
    
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Length Xt = 0;
      parameter Modelica.Units.SI.Length Yt = 0;
      parameter Real k = 0;
      
      parameter Real Color[3] = {200, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SupportShape(shapeType = "cylinder", length = 0.5, width = 0.3, height = 0.3, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {Xp, Yp, 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Units.SI.Force Rx;
      Modelica.Units.SI.Force Ry;
      KinematicInput Body_In;
      DynamicOutput F_Out;
    equation
    
      Xp = Body_In.X + Xt*cos(Body_In.Phi) - Yt*sin(Body_In.Phi);
      Yp = Body_In.Y + Xt*sin(Body_In.Phi) + Yt*cos(Body_In.Phi);
      F_Out.X = Xp;
      F_Out.Y = Yp;
      F_Out.Fx = Rx;
      F_Out.Fy = Ry;
      F_Out.M = -k*der(Body_In.Phi);
      
    end RustSupport2D;

    model Var_5_Rusty
      parameter Modelica.Units.SI.Length L1 = 1;
      parameter Modelica.Units.SI.Length L2 = 3;
      parameter Modelica.Units.SI.Length L3 = 4;
      parameter Modelica.Units.SI.Length L4 = 3;
      parameter Modelica.Units.SI.Length R = 1;
      
      parameter Modelica.Units.SI.Mass m1 = 1;
      parameter Modelica.Units.SI.Mass m2 = 3;
      parameter Modelica.Units.SI.Mass m3 = 6;
      parameter Modelica.Units.SI.Mass m4 = 4;
      parameter Modelica.Units.SI.Mass m5 = 3;
      
      parameter Modelica.Units.SI.Angle phi10 = 0.52;
      parameter Modelica.Units.SI.Angle phi20 = 5.24;
      parameter Modelica.Units.SI.Angle phi30 = 4.36;
      parameter Modelica.Units.SI.Angle phi40 = 3.32;
      parameter Modelica.Units.SI.Angle phip = 0;
      
      parameter Modelica.Units.SI.Length X0 = 15;
      parameter Modelica.Units.SI.Length Y0 = 15;
      parameter Modelica.Units.SI.Length XE = X0 + L1*cos(phi10) + L2*cos(phi20) + L3*cos(phi30);
      parameter Modelica.Units.SI.Length YE = Y0 + L1*sin(phi10) + L2*sin(phi20) + L3*sin(phi30);
      parameter Modelica.Units.SI.Length XK = X0 + L1*cos(phi10) + L2*cos(phi20) + L3/2*cos(phi30) + L4*cos(phi40) + R*sin(phip);
      parameter Modelica.Units.SI.Length YK = Y0 + L1*sin(phi10) + L2*sin(phi20) + L3/2*sin(phi30) + L4*sin(phi40) - R*cos(phip);
      
      TwoPortRod2D Palka1(L = L1, Color = {0, 150, 0}, Phi(start = phi10), m = m1);
      TwoPortRod2D Palka2(L = L2, Color = {0, 0, 150}, Phi(start = phi20), m = m2);
      ThreePortRod2D Palka3(L = L3, Color = {0, 0, 150}, Phi(start = phi30), m = m3);
      TwoPortRod2D Palka4(L = L4, Color = {0, 0, 150}, Phi(start = phi40), m = m4);
      TwoPortWheel2D Koleso(R = R, Color = {150, 0, 0}, m = m5);
      RustSupport2D Opora1(Xp = X0, Yp = Y0, Xt = -L1/2, Yt = 0, k = 1);
      //Support2D Opora1(Xp = X0, Yp = Y0, Xt = -L1/2, Yt = 0);
      Support2D Opora2(Xp = XE, Yp = YE, Xt = L3/2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1/2, Yt1 = 0, Xt2 = -L2/2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2/2, Yt1 = 0, Xt2 = -L3/2, Yt2 = 0);
      Joint2D Sharnir3(Xt1 = 0, Yt1 = 0, Xt2 = -L4/2, Yt2 = 0);
      //RustJoint2D Sharnir3(Xt1 = 0, Yt1 = 0, Xt2 = -L4/2, Yt2 = 0, k = 3);
      Joint2D Sharnir4(Xt1 = L4/2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      RollCircleOnLine Kachenie(Xp = XK, Yp = YK, Phip = phip, R = R);
      
    equation
    
      connect(Opora1.Body_In, Palka1.Body_Out);
      connect(Sharnir1.Body1_In, Palka1.Body_Out);
      connect(Sharnir1.Body2_In, Palka2.Body_Out);
      connect(Sharnir2.Body1_In, Palka2.Body_Out);
      connect(Sharnir2.Body2_In, Palka3.Body_Out);
      connect(Opora2.Body_In, Palka3.Body_Out);
      connect(Sharnir3.Body1_In, Palka3.Body_Out);
      connect(Sharnir3.Body2_In, Palka4.Body_Out);
      connect(Sharnir4.Body1_In, Palka4.Body_Out);
      connect(Sharnir4.Body2_In, Koleso.Body_Out);
      connect(Kachenie.Body_In, Koleso.Body_Out);
      
      connect(Opora1.F_Out, Palka1.F_A);
      connect(Sharnir1.F1_Out, Palka1.F_B);
      connect(Sharnir1.F2_Out, Palka2.F_A);
      connect(Sharnir2.F1_Out, Palka2.F_B);
      connect(Sharnir2.F2_Out, Palka3.F_A);
      connect(Opora2.F_Out, Palka3.F_C);
      connect(Sharnir3.F1_Out, Palka3.F_B);
      connect(Sharnir3.F2_Out, Palka4.F_A);
      connect(Sharnir4.F1_Out, Palka4.F_B);
      connect(Sharnir4.F2_Out, Koleso.F_A);
      connect(Kachenie.F_Out, Koleso.F_B);
      
    end Var_5_Rusty;

    model RustJoint2D
      parameter Modelica.Units.SI.Length Xt1 = 0;
      parameter Modelica.Units.SI.Length Yt1 = 0;
      parameter Modelica.Units.SI.Length Xt2 = 0;
      parameter Modelica.Units.SI.Length Yt2 = 0;
      parameter Real k = 0;
      Modelica.Units.SI.Length XSh;
      Modelica.Units.SI.Length YSh;
      parameter Real Color[3] = {0, 200, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape JointShape(shapeType = "cylinder", length = 0.5, width = 0.3, height = 0.3, lengthDirection = {0, 0, 1}, widthDirection = {1, 0, 0}, color = Color, specularCoefficient = 0.5, r = {XSh, YSh, 0}, R = orientation, r_shape = {0, 0, 0});
      KinematicInput Body1_In;
      KinematicInput Body2_In;
      Modelica.Units.SI.Force Rx;
      Modelica.Units.SI.Force Ry;
      DynamicOutput F1_Out;
      DynamicOutput F2_Out;
    equation
      XSh = Body1_In.X + Xt1*cos(Body1_In.Phi) - Yt1*sin(Body1_In.Phi);
      YSh = Body1_In.Y + Xt1*sin(Body1_In.Phi) + Yt1*cos(Body1_In.Phi);
      XSh = Body2_In.X + Xt2*cos(Body2_In.Phi) - Yt2*sin(Body2_In.Phi);
      YSh = Body2_In.Y + Xt2*sin(Body2_In.Phi) + Yt2*cos(Body2_In.Phi);
      F1_Out.X = XSh;
      F1_Out.Y = YSh;
      F1_Out.Fx = Rx;
      F1_Out.Fy = Ry;
      F1_Out.M = 0;
      F2_Out.X = XSh;
      F2_Out.Y = YSh;
      F2_Out.Fx = -Rx;
      F2_Out.Fy = -Ry;
      F2_Out.M = -k*(der(Body2_In.Phi) - der(Body1_In.Phi));
    end RustJoint2D;

    model RollCircleOnCircle
    
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Angle Phip = 0;
      parameter Modelica.Units.SI.Length R = 1;
      
      Modelica.Units.SI.Angle Ksi;
      
      parameter Real Color[3] = {0, 0, 150};
      parameter Modelica.Units.SI.Length Lp = 6*R;
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape CircleShape(shapeType = "cylinder", length = 0.2, width = Lp*2, height = Lp*2, lengthDirection = {0, 0, 1}, widthDirection = {cos(Phip), sin(Phip), 0}, color = Color, specularCoefficient = 0.5, r = {Xp, Yp, 0}, R = orientation, r_shape = {0, 0, 0});
      
      KinematicInput Body_In;
      
      Modelica.Units.SI.Force N;
      Modelica.Units.SI.Force Ftr;
      DynamicOutput F_Out;
    equation
    
      Xp = Body_In.X + (Lp+R)*(sin(Ksi));
    
      Yp = Body_In.Y + (Lp+R)*(cos(Ksi));
      
      der(Ksi) = -der(Body_In.Phi)/(R*3.14);
      
    
      F_Out.X = Xp;
      F_Out.Y = Yp;
      F_Out.Fx = -N*sin(Body_In.Phi) - Ftr*cos(Body_In.Phi);
      F_Out.Fy = N*cos(Body_In.Phi) - Ftr*sin(Body_In.Phi);
      F_Out.M = 0;
    
    end RollCircleOnCircle;

    model WheelOnCircle
    
      parameter Modelica.Units.SI.Length R1 = 3;
      parameter Modelica.Units.SI.Mass m1 = 1;
      
      TwoPortWheel2D Koleso(R = R1, Color = {150, 0, 0}, m = m1);
      
      RollCircleOnCircle Kachenie(Xp = 0, Yp = 0, R = R1, Ksi(start = 3));
      
    equation
    
      connect(Kachenie.Body_In, Koleso.Body_Out);
      
      connect(Kachenie.F_Out, Koleso.F_A);
      connect(Kachenie.F_Out, Koleso.F_B);
    
    end WheelOnCircle;
  end Lab_6;
end Filippov_VDMCD_Labs;
