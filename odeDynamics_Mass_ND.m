function dzdt=odeDynamics_Mass_ND(t,z,w)

dzdt=[z(3);z(4);0;-w];