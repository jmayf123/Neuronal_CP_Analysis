function MonkeyIdleStim

actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');
DA.SetSysMode(0);
DA.CloseConnection;
close(actxfigure);